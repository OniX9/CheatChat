import 'package:cheat_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cheat_chat/globals.dart';
import 'package:cheat_chat/widgets/onboardb_bottomSheet.dart';
import 'package:cheat_chat/widgets/four_pets.dart';

class OnBoardingBScreen extends StatefulWidget {
  static const String id = '/';

  const OnBoardingBScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingBScreen> createState() => _OnBoardingBScreenState();
}

class _OnBoardingBScreenState extends State<OnBoardingBScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> onBoardingWidgets = [
      const FourPets(),
      OnBoardingBBottomSheet(
        startchatbuttonCallBack: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            ChatScreen.id,
                (route) {
              return route.settings.name == ChatScreen.id ? true: false;
            },
          );
        },
      ),
    ];
    return Scaffold(
      body: Container(
        decoration: kLinearGradient,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: onBoardingWidgets,
        ),
      ),
    );
  }
}
