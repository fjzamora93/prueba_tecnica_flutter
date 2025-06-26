import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Ejemplo de cómo usar los colores y estilos en widgets
class ExampleUsageWidget extends StatelessWidget {
  const ExampleUsageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'Ejemplo de Uso',
          style: AppTextStyles.heading1,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Usando colores directamente
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.isValidGreen),
              ),
              child: Text(
                'Contenedor con colores personalizados',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.darkGreen,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Usando estilos de texto
            Text(
              'Título Principal',
              style: AppTextStyles.heading1,
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Subtítulo secundario',
              style: AppTextStyles.subtitle,
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Texto del cuerpo con información adicional.',
              style: AppTextStyles.body,
            ),
            
            const SizedBox(height: 16),
            
            // Botón con tema automático
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Botón Principal',
                style: AppTextStyles.button,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Botón outlined con tema automático
            OutlinedButton(
              onPressed: () {},
              child: const Text('Botón Secundario'),
            ),
            
            const SizedBox(height: 16),
            
            // Card con tema automático
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Título de la tarjeta',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Contenido de la tarjeta',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Campo de texto con tema automático
            const TextField(
              decoration: InputDecoration(
                labelText: 'Campo de texto',
                hintText: 'Escribe algo aquí...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
