import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/navigation/app_routes.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/theme/theme.dart';
import 'package:pruebakidsandclouds/core/widgets/logo.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_scaffold.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/auth_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/login_texfield.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/password_field.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _emailCtrl    = TextEditingController();
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

      final user = ref.read(authProvider).value;
      if (user != null) {
        // Redirigir a la pantalla de lista de niños
        ctx.pushNamed(AppRoutes.home);
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Error al iniciar sesión')),
        );
      }       
     
    } catch (e) {
      _handleError(ctx, e.toString());
    }
  }


  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    if (kDebugMode){
      _emailCtrl.text = 'test02@gmail.com';
      _passwordCtrl.text = 'Pa\$\$w0rd';

    }


    ref.listen(authProvider, (_, next) {
      next.whenOrNull(
        error: (e, _) => _handleError(ctx, e.toString()),
      );
    });

    final theme = Theme.of(ctx);

    return PrimaryScaffold(
      hideBottonNavigationBar: true,
      appBar: null,
      children: [
        const SizedBox(height: 20),
        const Logo(),
        const SizedBox(height: 70),
        Text(
          "Iniciar sesión", 
          style: AppTextStyles.heading2
          ),
        const SizedBox(height: 24),

        LoginTextField(
          label: "Correo electrónico",
          controller: _emailCtrl,
          isError: auth.hasError, 
          obscureText: false,
        ),
        
        const SizedBox(height: 16),
        PasswordFieldWidget(
          controller: _passwordCtrl,
          isError: auth.hasError,
        ),

        const SizedBox(height: 8),
        
        const SizedBox(height: 8),

        ElevatedButton(
          onPressed: auth.isLoading ? null : () => _login(ctx, ref),
          child: auth.isLoading
              ? const CircularProgressIndicator()
              : const Text('Ingresar'),
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
