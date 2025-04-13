import 'dart:io' show sleep;
import 'package:flutter/material.dart';
import 'package:cheat_chat/globals.dart';
import 'package:cheat_chat/widgets/onboarda_bottomSheet.dart';
import 'package:cheat_chat/widgets/four_pets.dart';
import 'package:cheat_chat/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = '/OnBoardingAPage';

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  bool animationLock = true;
  double animatedBottomSheetHeight = 30; // Equate to controller1.lowerBound

  late AnimationController controller1 = AnimationController(
    vsync: this,
    upperBound: 640,
    lowerBound: 30,
    duration: const Duration(milliseconds: 3000),
  );

  animateBottomSheetFully() {
    /// Animates bottom sheet height half way (at 340),
    /// then fully once animation lock is false,
    /// animation lock equals the opposite bool of startChatButtonState.
    controller1.addListener(() {
      setState(() {
        animatedBottomSheetHeight = controller1.value;
        if (controller1.value>= 340 && animationLock){
          controller1.stop(canceled: false);
          // Forces height to stick to 342, incase the UI freezes.
          animatedBottomSheetHeight = 342;
        }
      });
    });
    controller1.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animateBottomSheetFully();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    controller1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var consumer = Provider.of<UIProvider>(context);
    List<Widget> onBoardingWidgets = [
      Visibility(
        //fills up avaliable space when FourPets() becomes Invisible,
        // would also be animated to the top.
        visible: consumer.startChatButtonState,
        child: Expanded(
          // Make sure flex value is equal to the FourPets()'s Expanded flex value.
          child: SizedBox(),
        ),
      ),
      Visibility(
        visible: !consumer.startChatButtonState,
        child: const FourPets(),
      ),
      OnBoardingABottomSheet(
        bottomSheetAnimatedHeight: animatedBottomSheetHeight,
        startchatbuttonCallBack: () {
          setState(() {
            consumer.toggleStartChatButton();
            animationLock = !consumer.startChatButtonState;
          });
          controller1.forward(from: 342);
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
