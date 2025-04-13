import 'package:flutter/material.dart';

TextStyle kAgreementTextStyle = TextStyle(
  wordSpacing: 1.2,
    fontSize: 14,
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
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFFACB5BB),
    height: 1.5,
);
