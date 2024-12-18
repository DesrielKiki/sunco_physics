import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/interactive_point.dart';

class VerticalLinePainter extends CustomPainter {
  final List<InteractivePoint> points;
  final List<double> opacityValues; // Opacity untuk garis

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

    // Menggambar garis dengan opacity
    for (int i = 0; i < points.length; i++) {
      final InteractivePoint point = points[i];
      final double opacity = opacityValues[i]; // Opacity yang sedang berlaku untuk garis

      final Offset start = point.position;
      final Offset end = Offset(start.dx, start.dy + point.lineLength);

      // Mengatur opacity garis dengan benar
      linePaint.color = Colors.blue.withOpacity(opacity);
      canvas.drawLine(start, end, linePaint); // Menggambar garis
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
