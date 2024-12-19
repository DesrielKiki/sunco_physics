import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class QuestionButton extends StatelessWidget {
  final String title;
  final String question;
  final String answer;

  const QuestionButton({
    super.key,
    required this.title,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedTextColor: ColorConfig.onPrimaryColor,
      collapsedIconColor: ColorConfig.onPrimaryColor,
      collapsedBackgroundColor: ColorConfig.primaryColor,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            question,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Jawab:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
