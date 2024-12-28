import 'package:flutter/material.dart';

class FormulaText extends StatelessWidget {
  final String formula;
  final String description;
  const FormulaText({
    super.key,
    required this.formula,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            formula,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Keterangan : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
