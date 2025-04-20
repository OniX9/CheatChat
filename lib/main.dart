import 'package:cheat_chat/imports/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatUIProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingUIProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OtherUserProvider()),
        ChangeNotifierProvider(create: (_) => InternetCheckProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.id,
          theme:  ThemeData(
        fontFamily: Fonts.nunitoSans,
        colorScheme: ColorScheme.fromSeed(seedColor: kAppBlue),
        useMaterial3: true,
      ),
          routes: {
            SplashScreen.id : (context) => SplashScreen(),
            OnBoardingScreen.id : (context) => OnBoardingScreen(),
            ChatScreen.id : (context) => ChatScreen(),
          }
      ),
    );
  }
}
