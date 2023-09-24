import 'package:flutter/material.dart';

class AlignedPetImage extends StatelessWidget {
  final AlignmentGeometry alignment;
  final String imagePath;
  final bool isVector;

  const AlignedPetImage({
    required this.alignment,
    required this.imagePath,
    this.isVector = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: isVector ? EdgeInsets.all(10.0) : EdgeInsets.all(14.0) ,
        decoration: BoxDecoration(
          color: isVector ? Colors.transparent : Colors.white24,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          imagePath,
        ),
      ),
    );
  }
}
