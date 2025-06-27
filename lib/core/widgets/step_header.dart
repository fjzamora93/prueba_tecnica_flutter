import 'package:flutter/material.dart';

class StepHeader extends StatelessWidget {
  final int currentStep;
  final int maxStep;
  final VoidCallback onBack;

  const StepHeader({
    Key? key,
    required this.currentStep,
    required this.maxStep,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        Expanded(
          child: Center(
            child: Text(
              'Paso $currentStep de $maxStep',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 48), // para balancear el espacio del IconButton
      ],
    );
  }
}
