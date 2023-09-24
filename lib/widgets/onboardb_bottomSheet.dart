import 'package:flutter/material.dart';
import 'package:cheat_chat/providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:cheat_chat/globals.dart';

class OnBoardingBBottomSheet extends StatefulWidget {
  void Function() startchatbuttonCallBack;

  OnBoardingBBottomSheet({Key? key, required this.startchatbuttonCallBack})
      : super(key: key);

  @override
  State<OnBoardingBBottomSheet> createState() => _OnBoardingBBottomSheetState();
}

class _OnBoardingBBottomSheetState extends State<OnBoardingBBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  void bottomSheetAnimator() {
    controller = AnimationController(
      vsync: this,
      upperBound: 400,
      lowerBound: 200,
      duration: Duration(milliseconds: 1300),
    );
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    bottomSheetAnimator();
  }

  @override
  void deactivate() {
    super.deactivate();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var consumer = Provider.of<UIProvider>(context);
    return Expanded(
      flex: controller.value.toInt(),
      child: Center(
        child: Container(
          decoration: kRoundedTopBoxDecoration,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Image.asset(
                'images/cc 1.png',
                width: 70,
                height: 70,
              ),
              const SizedBox(width: double.infinity),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 23),
                child: Text(
                  'Chat anonymously with people, make friends',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    height: 1.3,
                  ),
                ),
              ),
              Text(
                'Chat up different people from different parts of the world. make friends and have fun',
                textAlign: TextAlign.center,
                style: kDescriptionTextStyle,
              ),
              Text(
                'Must be 18 or older to use Cheatchat',
                textAlign: TextAlign.center,
                style: kAgreementTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  onPressed: widget.startchatbuttonCallBack,
                  color: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Column(
                    children: [
                      SizedBox(width: double.maxFinite),
                      Text(
                        'Start a chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
