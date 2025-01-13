import 'package:flutter/material.dart';

class OutputCalculator extends StatelessWidget {
  final String known;
  final String asked;
  final String answer;
  final String conclusion;

  const OutputCalculator({
    super.key,
    required this.known,
    required this.asked,
    required this.answer,
    required this.conclusion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Hasil Perhitungan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Diketahui : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(known),
          const SizedBox(height: 8),
          const Text(
            'Ditanya : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(asked),
          const SizedBox(height: 8),
          const Text(
            'Jawaban : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(answer),
          const SizedBox(height: 8),
          const Text(
            'Kesimpulan : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(conclusion),
        ],
      ),
    );
  }
}
