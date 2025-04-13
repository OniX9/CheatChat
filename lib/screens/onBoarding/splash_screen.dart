import 'dart:ui';
import 'package:cheat_chat/imports/imports.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  void startBouncingAnimation() {
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
    startBouncingAnimation();
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
                  'assets/images/blur_circle.png',
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
                'assets/images/cc 1.png',
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
