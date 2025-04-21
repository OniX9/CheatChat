import 'package:cheat_chat/imports/imports.dart';

const Color kAppGreenMain = Color(0xFF1CE7B2);
const Color kAppGreenDark = Color(0x8F1CE7B2);
const Color kAppBlue = Color(0xFF394FE1);
const Color kAppBlack = Color(0xFF1E1E1E);

const kLinearGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      kAppGreenMain,
      kAppGreenDark,
      Color(0xEF1CE7B2),
      kAppGreenMain,
    ],
  ),
);