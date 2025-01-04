import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class QuestionButton extends StatelessWidget {
  final String title;
  final String question;
  final String known;
  final String asked;
  final String answer;
  final String conclusion;

  const QuestionButton({
    super.key,
    required this.title,
    required this.question,
    required this.known,
    required this.asked,
    required this.answer,
    required this.conclusion,
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
        ListTile(
          title: Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
        ),
        const ListTile(
          title: Text(
            "Diketahui :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            known,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
          ),
        ),
        const ListTile(
          title: Text(
            "Ditanya :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            asked,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
          ),
        ),
        const ListTile(
          title: Text(
            "Jawaban :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text(
            answer,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
          ),
        ),
        ListTile(
          title: Text(
            conclusion,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
