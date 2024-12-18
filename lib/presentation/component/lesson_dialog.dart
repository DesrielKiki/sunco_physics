import 'package:flutter/material.dart';

class LessonDialog extends StatelessWidget {
  final String description;

  const LessonDialog({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Penjelasan Objek"),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Tutup"),
        ),
      ],
    );
  }
}
