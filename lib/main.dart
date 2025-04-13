import 'package:cheat_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cheat_chat/screens/loading_screen.dart';
import 'package:cheat_chat/screens/onBoarding/onboardinga_screen.dart';
import 'package:cheat_chat/screens/onBoarding/onboardingb_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cheat_chat/providers/ui_provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: LoadingScreen.id,
          theme: ThemeData(
            fontFamily: 'NunitoSans',
          ),
          routes: {
            LoadingScreen.id : (context) => LoadingScreen(),
            OnBoardingScreen.id : (context) => OnBoardingScreen(),
            OnBoardingBScreen.id : (context) => OnBoardingBScreen(),
            ChatScreen.id : (context) => ChatScreen(),
          }
      ),
    );
  }
}
