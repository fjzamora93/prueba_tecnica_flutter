import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_text_field.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/user.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/auth_provider.dart';

class EditUserDialog extends ConsumerStatefulWidget {
  final User user;

  const EditUserDialog({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends ConsumerState<EditUserDialog> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;

  
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0),
        ),
      ),
      child: Container(
        width: isDesktop ? 500 : null,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: isDesktop ? 500 : MediaQuery.of(context).size.width * 0.9,
        ),
        padding: EdgeInsets.all(
          ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título del diálogo
              Row(
                children: [
                  Icon(
                    Icons.edit_rounded,
                    color: AppColors.primary,
                    size: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 28.0),
                  ),
                  SizedBox(width: ResponsiveHelper.responsiveValue(context, mobile: 8.0, desktop: 12.0)),
                  Text(
                    'Editar Perfil',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontSize: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 24.0),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  ),
                ],
              ),
              
              SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 24.0)),
              
              // Avatar del usuario
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: ResponsiveHelper.responsiveValue(context, mobile: 40.0, desktop: 50.0),
                      backgroundImage: NetworkImage(widget.user.image),
                      onBackgroundImageError: (_, __) {},
                      child: widget.user.image.isEmpty 
                          ? Icon(
                              Icons.person,
                              size: ResponsiveHelper.responsiveValue(context, mobile: 40.0, desktop: 50.0),
                              color: AppColors.textSecondary,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 18.0),
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),
              
              // Campos editables
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: _firstNameController,
                        label: 'Nombre',
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'El nombre es obligatorio';
                          }
                          return null;
                        },
                      ),
                      
                      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
                      
                      CustomTextField(
                        controller: _lastNameController,
                        label: 'Apellido',
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'El apellido es obligatorio';
                          }
                          return null;
                        },
                      ),
                      
                      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
                      
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'El email es obligatorio';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                            return 'Email no válido';
                          }
                          return null;
                        },
                      ),
                      
                      SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
                      
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0)),
              
              // Botones de acción
              Row(
                children: [
                  // Botón Cancelar
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () => Navigator.of(context).pop(),
                      text: 'Cancelar',
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  SizedBox(width: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
                  
                  // Botón Guardar
                  Expanded(
                    child: PrimaryButton(
                      onPressed: _saveChanges,
                      text: 'Guardar',
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      // Crear usuario actualizado
      final updatedUser = widget.user.copyWith(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),

      );

      // Actualizar en el provider
      ref.read(authProvider.notifier).updateUser(updatedUser);

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil actualizado correctamente'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 2),
        ),
      );

      // Cerrar diálogo
      Navigator.of(context).pop();
    }
  }
}