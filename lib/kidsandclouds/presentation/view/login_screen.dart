import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_loading_indicator.dart';
import 'package:pruebakidsandclouds/core/widgets/logo.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/auth_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/login_texfield.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/password_field.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;

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
      loading: () {
        _isLoading = true;
      },
      error: (error, _) {
        _handleError(ctx, error.toString());
      },
    );
  } catch (e) {
    _handleError(ctx, e.toString());
  }
}


  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    
    _emailCtrl.text = 'michaelw';
    _passwordCtrl.text = 'michaelwpass';

    


    ref.listen(authProvider, (_, next) {
      next.whenOrNull(
        error: (e, _) => _handleError(ctx, e.toString()),
      );
    });

    final theme = Theme.of(ctx);

    return PrimaryScaffold(
      backgroundColor: AppColors.white,
      hideBottonNavigationBar: true,
      appBar: null,
      children: [
        const SizedBox(height: 20),
        const Logo(),
        const SizedBox(height: 70),
      ref.watch(authProvider).when(
        loading: () => CustomLoadingIndicator(),
        error: (error, _) => Text('Error: $error'),
        data: (user) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Iniciar sesión", 
              style: AppTextStyles.heading2
            ),
            const SizedBox(height: 24),
            LoginTextField(
              label: "Username",
              controller: _emailCtrl,
              isError: authState.hasError, 
              obscureText: false,
            ),
            
            const SizedBox(height: 16),
            PasswordFieldWidget(
              controller: _passwordCtrl,
              isError: authState.hasError,
            ),

            const SizedBox(height: 8),
            
            const SizedBox(height: 8),

            PrimaryButton(
              onPressed: authState.isLoading ? null : () => _login(ctx, ref),
            ),
          ],
        ),
      ),

      const SizedBox(height: 24),
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


      ],
    );
  }
}
