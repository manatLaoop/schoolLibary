import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:math' as math;

class Returnof extends StatefulWidget {
  const Returnof({super.key});

  @override
  State<Returnof> createState() => _returRfStatoe();
}

class _returRfStatoe extends State<Returnof> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        color: Colors.grey[200], // Add background
        child: CustomPaint(
          size: Size(500, 500),
          painter: person(color: Color.fromARGB(255, 27, 186, 175)),
        ),
      ),
    ));
  }
}

class person extends CustomPainter {
  person({required Color this.color});
  late Color color;
  @override
  void paint(Canvas canvas, Size size) {
    double W = size.width;
    double H = size.height;

    // clipping circle
    Path pathCircle = Path()
      ..addOval(Rect.fromCircle(center: Offset(W / 2, H / 2), radius: W / 2))
      ..close();
    canvas.clipPath(pathCircle);

    // draw triangle.
    Paint paintTriangle = Paint()..color = color;
    Paint paintTriangle2 = Paint()..color = Colors.redAccent;

    Path pathTriangle2 = Path()
      ..moveTo(W / 2, H / 2)
      ..lineTo(0, 0)
      ..lineTo(W, 0)
      ..close();
    canvas.drawPath(pathTriangle2, paintTriangle2);

    Path pathTriangle = Path()
      ..moveTo(W / 2, H / 2)
      ..lineTo(0, H)
      ..lineTo(W, H)
      ..close();
    canvas.drawPath(pathTriangle, paintTriangle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
