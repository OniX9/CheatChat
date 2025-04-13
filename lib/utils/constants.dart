import 'package:flutter/material.dart';

const kLinearGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF1CE7B2),
      Color(0x8F1CE7B2),
      Color(0xEF1CE7B2),
      Color(0xFF1CE7B2),
    ],
  ),
);

TextStyle kAgreementTextStyle = TextStyle(
  wordSpacing: 1.2,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF6A6D74),
    height: 1.5,
);

BoxDecoration kRoundedTopBoxDecoration = const BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);

TextStyle kDescriptionTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFFACB5BB),
    height: 1.5,
);
