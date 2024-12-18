import 'package:flutter/material.dart';

class InteractivePoint {
  final Offset position;
  final double lineLength;
  final String description;

  InteractivePoint({
    required this.position,
    required this.lineLength,
    required this.description,
  });
}
