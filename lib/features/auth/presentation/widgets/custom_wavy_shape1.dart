
import 'package:flutter/material.dart';

class CustomWavyShape1 extends StatelessWidget {
  const CustomWavyShape1({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomWave1(),
      child: Container(),
    );
  }
}

class CustomWave1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.orange;
    final path = Path();

    path.moveTo(size.width, size.height * 0.40);

    path.quadraticBezierTo(size.width * 0.85, size.height * 0.9,
        size.width * 0.7, size.height * 0.85);

    path.quadraticBezierTo(size.width * 0.5, size.height * 0.55,
        size.width * 0.35, size.height * 0.85);

    path.quadraticBezierTo(size.width * 0.2, size.height,
        size.width * 0.05, size.height * 0.85);

    path.quadraticBezierTo(
        size.width * 0, size.height * 0.75, 0, size.height);


    path.lineTo(size.width, size.height);
    
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}