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
  late AnimationController controller1 = AnimationController(
    vsync: this,
    upperBound: 630,
    lowerBound: 30,
    duration: const Duration(milliseconds: 3000),
  );

  animateBottomSheetFully() {
    /// Animates bottom sheet half
    ///
    ///
    controller1.addListener(() {
      setState(() {
        if (controller1.value>= 340 && animationLock){
          controller1.stop(canceled: false);
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
        bottomSheetAnimatedHeight: controller1.value,
        startchatbuttonCallBack: () {
          setState(() {
            consumer.toggleStartChatButton();
            animationLock = !consumer.startChatButtonState;
          });
          // sleeps, so UI builds before bottomsheet full render.
          sleep( const Duration(milliseconds: 70));
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
