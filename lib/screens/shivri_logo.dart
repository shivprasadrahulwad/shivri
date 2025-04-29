import 'dart:math';

import 'package:flutter/material.dart';

class ClaudeLogo extends StatelessWidget {
  final double size;
  
  const ClaudeLogo({
    super.key,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: ClaudeLogoPainter(),
    );
  }
}

class ClaudeLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = const Color(0xFFC97C5D)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    
    // Draw the starburst logo as seen in the image
    final radius = size.width / 2;
    const lines = 12;
    
    for (var i = 0; i < lines; i++) {
      final angle = (i * 2 * 3.14159) / lines;
      final start = Offset(
        center.dx + (radius * 0.4) * cos(angle),
        center.dy + (radius * 0.4) * sin(angle),
      );
      final end = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}