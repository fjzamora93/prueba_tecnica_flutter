import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_loading_indicator.dart';
import 'package:pruebakidsandclouds/core/widgets/logo.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/auth_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/login_texfield.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/password_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  /*──────── helper ────────*/
  void _handleError(BuildContext ctx, String error) {
    String message;
    if (error.contains('Invalid password')) {
      message = 'Contraseña incorrecta';
    } else if (error.contains('User not found')) {
      message = 'El usuario no esta registrado. Regístrate';
    } else {
      message = 'Error al iniciar sesión. Intente nuevamente';
    }
    
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _login(BuildContext ctx, WidgetRef ref) async {
    if (_emailCtrl.text.trim().isEmpty || _passwordCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Complete todos los campos')),
      );
      return;
    }

    final authNotifier = ref.read(authProvider.notifier);
    try {
      await authNotifier.login(_emailCtrl.text.trim(), _passwordCtrl.text.trim());
      final authState = ref.read(authProvider);
      authState.when(
        data: (user) {
          if (user != null) {
            ctx.go(AppRoutes.home);
          } else {
            ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Error: Usuario no válido')),
            );
          }
        },
        loading: () {},
        error: (error, _) {
          _handleError(ctx, error.toString());
        },
      );
    } catch (e) {
      _handleError(ctx, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    _emailCtrl.text = 'michaelw';
    _passwordCtrl.text = 'michaelwpass';

    ref.listen(authProvider, (_, next) {
      next.whenOrNull(
        error: (e, _) => _handleError(context, e.toString()),
      );
    });

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ResponsiveHelper.isDesktop(context)
            ? _buildDesktopLayout(context, authState, theme)
            : _buildMobileLayout(context, authState, theme),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AsyncValue authState, ThemeData theme) {
    return ListView(
      padding: ResponsiveHelper.responsivePadding(context),
      children: _buildLoginContent(context, authState, theme),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AsyncValue authState, ThemeData theme) {
    return Center(
      child: Container(
        width: ResponsiveHelper.getContentWidth(context) * 0.4,
        constraints: const BoxConstraints(maxWidth: 400),
        padding: ResponsiveHelper.responsivePadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildLoginContent(context, authState, theme),
        ),
      ),
    );
  }

  List<Widget> _buildLoginContent(BuildContext context, AsyncValue authState, ThemeData theme) {
    return [
      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 40.0)),
      const Logo(),
      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 70.0, desktop: 50.0)),
      
      ref.watch(authProvider).when(
        loading: () => const CustomLoadingIndicator(),
        error: (error, _) => Text('Error: $error'),
        data: (user) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).loginButton, 
              style: AppTextStyles.heading2
            ),
            SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),
            LoginTextField(
              label: S.of(context).username,
              controller: _emailCtrl,
              isError: authState.hasError, 
              obscureText: false,
            ),
            
            SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
            PasswordFieldWidget(
              controller: _passwordCtrl,
              isError: authState.hasError,
            ),

            SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),

            PrimaryButton(
              onPressed: authState.isLoading ? null : () => _login(context, ref),
            ),
          ],
        ),
      ),

      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),
      Row(
        children: [
          const Expanded(child: Divider(color: AppColors.lightGrey)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('o', style: theme.textTheme.bodyMedium),
          ),
          const Expanded(child: Divider(color: AppColors.lightGrey)),
        ],
      ),
    ];
  }
}
