import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class NumericDataRow extends StatelessWidget {
  final int age;
  final int anotherData;

  const NumericDataRow({
    super.key,
    required this.age,
    required this.anotherData,
  });

  @override
  Widget build(BuildContext context) {
    final bool notAtHome = anotherData% 2 == 0; // Simulamos una condición aleatoria
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Pago
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pago:', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.isValidGreen),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green.shade50,
                ),
                child: Text(
                  '${age.toStringAsFixed(2)}€',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),


          // Asientos disponibles
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                notAtHome ? 'Niño no disponible' : 'El niño sí está en casa',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue.shade50,
                ),
                child: notAtHome
                    ? const Icon(Icons.event_seat, color: AppColors.primary)
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                            anotherData,
                            (index) => const Icon(Icons.person, color: AppColors.orangeGold, size: 20),
                          ),

                          const SizedBox(width: 4),
                          Text(
                            '$anotherData',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      
    );
  }
}