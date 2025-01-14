import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/interactive_point.dart';

class VerticalLinePainter extends CustomPainter {
  final List<InteractivePoint> points;
  final List<double> opacityValues;

  VerticalLinePainter({
    required this.points,
    required this.opacityValues,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length; i++) {
      final InteractivePoint point = points[i];
      final double opacity = opacityValues[i];

      final Offset start = point.position;
      final Offset end = Offset(start.dx, start.dy + point.lineLength);

      linePaint.color = Colors.blue.withOpacity(opacity);
      canvas.drawLine(start, end, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
