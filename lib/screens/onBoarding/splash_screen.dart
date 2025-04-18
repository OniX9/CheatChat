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
  bool onBoarded = false;
  late AnimationController controller;

  loadUser() {
    var userConsumer = Provider.of<UserProvider>(context, listen: false);
    var chatUIConsumer = Provider.of<ChatUIProvider>(context, listen: false);
    userConsumer.loadUserFromPreferences().then((_) {
      var user = userConsumer.getUser;
      if (user != null) {
        // Set Chat button to NewChat, if user has already ended chat.
        ChatButtonTypes chatButtonType = user.searching == true
            ? ChatButtonTypes.newChat
            : ChatButtonTypes.endChat;
        chatUIConsumer.updateChatButtonType(chatButtonType);
        // Fetch new user info
        userConsumer.apiUpdateUser(context);
      }
    });
  }

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

  Future<void> checkHasOnBoarded() async {
    onBoarded = await SharedPref().hasOnBoarded();
  }

  void nextScreen() async {
    Future.delayed(const Duration(milliseconds: 6000), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (onBoarded) {
          // if (false) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            ChatScreen.id,
            (route) => false,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            OnBoardingScreen.id,
          );
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkHasOnBoarded();
    loadUser();
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
