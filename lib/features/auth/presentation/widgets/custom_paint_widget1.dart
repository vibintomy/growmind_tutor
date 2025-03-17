
import 'package:flutter/material.dart';

class CustomPaintWidget1 extends StatelessWidget {
  const CustomPaintWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyShape1(),
      child: Container(),
    );
  }
}

class MyShape1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final paint = Paint();
    final path = Path();  
    paint.style = PaintingStyle.fill;
    paint.color = Colors.orange;
    paint.strokeWidth = 3;
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.4,
        size.width * 0.3, size.height * 0.5);

    path.quadraticBezierTo(size.width * 0.5, size.height * 0.7,
        size.width * 0.65, size.height * 0.5);

    path.quadraticBezierTo(size.width * 0.75, size.height * 0.75,
        size.width * 0.85, size.height * 0.7);

    path.quadraticBezierTo(size.width * 0.8, size.height * 0.3, size.width * 1.0,
        size.height * 0.4);
        //  path.quadraticBezierTo(size.width * 0.95, size.height * 0.6, size.width,
        // size.height * 0.3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
