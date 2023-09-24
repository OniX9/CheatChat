import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cheat_chat/screens/onboardinga_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = '/LoadingScreen';

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  void bouncingAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1350),
      upperBound: 130,
      lowerBound: 80,
    );
    controller.forward();
    controller.addListener(() {
      setState(() {});
      controller.value;
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  void nextScreen() async {
    Future.delayed(const Duration(milliseconds: 6000), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(
          context,
          OnBoardingScreen.id,
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    bouncingAnimation();
    nextScreen();
  }

  @override
  void deactivate() {
    super.deactivate();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 135),
              child: Container(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'images/loading_screen/blur_circle.png',
                  height: controller.value * 1.50,
                  width: controller.value * 1.60,
                ),
              ),
            ),
          ),
          Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 83, sigmaY: 83),
              child: Image.asset(
                'images/cc 1.png',
                height: controller.value - 23,
                width: controller.value - 23,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
