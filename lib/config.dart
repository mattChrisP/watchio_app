import 'package:flutter/material.dart';

class Config {
  final double kDefaultPadding = 16.0;
  final Color lightGreenishBlue = Color(0xff42f5d7);
  final Color lightGreenishYellow = Color(0xffd1fc86);
  final Color bluenishPurple = Color(0xff8545f5);
  final Color lightSilverBlue = Color(0xffd0f5f1);
  final Color lightSilverPurple = Color(0xffdacbf2);
  final Color darkBlue = Color(0xff40677d);
  final Color darkPolkadot = Color(0xff0d423b);
  final Color darkPurple = Color(0xff3e2766);
  final Color lightOrange = Color(0xfff5e3c6);
  final Color superLightOrange = Color(0xffFFF9E3);
  final Color mediumPurple = Color(0xffad7aeb);
  final Color mediumPink = Color(0xfffc60d0);
  final Color mediumBlue = Color(0xff4124ff);
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
