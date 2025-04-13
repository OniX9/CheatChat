import 'package:cheat_chat/imports/imports.dart';

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
          initialRoute: SplashScreen.id,
          theme: ThemeData(
            fontFamily: 'NunitoSans',
          ),
          routes: {
            SplashScreen.id : (context) => SplashScreen(),
            OnBoardingScreen.id : (context) => OnBoardingScreen(),
            OnBoardingBScreen.id : (context) => OnBoardingBScreen(),
            ChatScreen.id : (context) => ChatScreen(),
          }
      ),
    );
  }
}
