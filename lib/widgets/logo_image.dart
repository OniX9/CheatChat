import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  final double radius;

  const LogoImage({
    this.radius = 70,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/cc 1.png',
      width: radius,
      height: radius,
    );
  }
}
