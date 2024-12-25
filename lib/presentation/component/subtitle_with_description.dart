import 'package:flutter/material.dart';

class SubtitleWithDescription extends StatefulWidget {
  final String subtitle;
  final String description;
  const SubtitleWithDescription({
    super.key,
    required this.subtitle,
    required this.description,
  });
  @override
  State<SubtitleWithDescription> createState() =>
      _SubtitleWithDescriptionState();
}

class _SubtitleWithDescriptionState extends State<SubtitleWithDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.subtitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.description,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
