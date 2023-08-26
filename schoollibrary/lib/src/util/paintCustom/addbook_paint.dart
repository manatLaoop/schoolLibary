import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class addBookPiant extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint piant = Paint()..color = Colors.blueGrey;

    double W = size.width;
    double H = size.height;

    Offset offset = Offset(0, 0);

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, H)
      ..lineTo(W, H)
      ..close();

    canvas.drawPath(path, piant);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
