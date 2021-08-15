import 'package:flutter/material.dart';

class Config {
  final double kDefaultPadding = 16.0;
  final Color lightGreenishBlue = Color(0xff42f5d7);
  final Color lightGreenishYellow = Color(0xffd1fc86);
  final Color lightSilverBlue = Color(0xffd0f5f1);
  final Color darkBlue = Color(0xff40677d);
  final Color lightOrange = Color(0xfff5e3c6);
  final Color mediumPurple = Color(0xffad7aeb);
}

Config config = Config();

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = config.mediumPurple;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
