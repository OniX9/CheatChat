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
    with TickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    upperBound: 400,
    lowerBound: 30,
    duration: const Duration(milliseconds: 1500),
  );

  animateBottomSheetFully() {
    controller.addListener(() {
      setState(() {
        controller.value;
      });
    });
    controller.reverse();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.forward();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var consumer = Provider.of<UIProvider>(context);
    List<Widget> onBoardingWidgets = [
      Visibility(
        //fills up avaliable space when FourPets() becomes Invisible,
        // would also be animated to the top.
        visible: !consumer.startChatButtonState,
        child: Expanded(
          // Make sure flex value is equal to the FourPets()'s Expanded flex value.
          flex: controller.value.toInt(),
          child: SizedBox(),
        ),
      ),
      Visibility(
        visible: consumer.startChatButtonState,
        child: const FourPets(),
      ),
      OnBoardingABottomSheet(
        startchatbuttonCallBack: () {
          setState(() {
            consumer.toggleStartChatButton();
            animateBottomSheetFully();
          });
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
