import 'package:cheat_chat/imports/imports.dart';
import 'package:cheat_chat/widgets/button_filled.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = '/OnBoardingPage';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    var uiConsumer = Provider.of<OnBoardingUIProvider>(context);
    return Scaffold(
      body: Container(
        decoration: kLinearGradient,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: !uiConsumer.startChatButtonState,
              child: const FourPets(),
            ),
            CustomBottomSheet(),
          ],
        ),
      ),
    );
  }
}

//***SCREEN-ONLY WIDGETs***
// 1.
class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final utils = Utilities();
  final variables = Variables();

  void setOnBoarded() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final hasOnBoarded = await SharedPref().hasOnBoarded();
    if (!hasOnBoarded) {
      sharedPreferences.setBool(variables.onBoard, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var uiConsumer = Provider.of<OnBoardingUIProvider>(context);
    var userConsumer = Provider.of<UserProvider>(context);

    registerGuest() async {
      // Checks
      // 1. Must be 18 or older, and has agreed.
      if (uiConsumer.is18OrOlder == false && uiConsumer.isAgreed == false) {
        return;
      }

      utils.showLoadingScreen(context);
      var newUser = await userConsumer.apiCreateUser(context);

      if (newUser != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          ChatScreen.id,
          (Route<dynamic> route) => false,
        );
        setOnBoarded();
      }
    }

    // These widgets are added to the bottom sheet when the user clicks on the start chat button
    List<Widget> adddedWidgets = [
      Row(
        children: [
          Transform.scale(
            scale: 1.2,
            child: CustomCheckbox(
              onChanged: uiConsumer.toggle18OrOlder,
            ),
          ),
          SizedBox(width: 5),
          Text(
            'I am 18 or older',
            style: kAgreementTextStyle.copyWith(height: 0),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 1.2,
            child: CustomCheckbox(
              onChanged: uiConsumer.toggleAgreed,
            ),
          ),
          SizedBox(width: 5),
          Flexible(
            child: RichText(
              // 'By checking the box you agree to our terms and conditions,privacy policy and Guidelines',
              // style: kAgreementTextStyle,
              softWrap: true,
              text: TextSpan(
                text: 'By checking the box you agree to our ',
                style: kAgreementTextStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: 'terms and conditions,',
                      style: kAgreementTextStyle.copyWith(
                        decoration: TextDecoration.underline,
                        color: Color(0xFF5F71E5),
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('clicked Terms and Conditions');
                        }),
                  TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                      text: 'privacy policy',
                      style: kAgreementTextStyle.copyWith(
                        decoration: TextDecoration.underline,
                        color: Color(0xFF5F71E5),
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('clicked Privacy Policy');
                        }),
                  TextSpan(
                    text: ' and ',
                  ),
                  TextSpan(
                      text: 'Guidelines',
                      style: kAgreementTextStyle.copyWith(
                        decoration: TextDecoration.underline,
                        color: Color(0xFF5F71E5),
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('clicked GuideLines');
                        }),
                ],
              ),
            ),
          ),
        ],
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          'assets/images/crocodile_2.png',
        ),
      ),
    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1100),
      decoration: kRoundedTopBoxDecoration,
      height: uiConsumer.startChatButtonState ? 640 : 320,
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Image.asset(
              'assets/images/cc 1.png',
              width: 70,
              height: 70,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
              child: Text(
                'chat anonymously with people, make friends',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF27292E),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1.3,
                ),
              ),
            ),
            Text(
              'chat up different people from different parts of the world. make friends and have fun',
              textAlign: TextAlign.center,
              style: kDescriptionTextStyle,
            ),
            SizedBox(height: 3),
            Text(
              'Must be 18 or older to use Cheatchat',
              textAlign: TextAlign.center,
              style: kAgreementTextStyle,
            ),
            if (uiConsumer.startChatButtonState) ...adddedWidgets,
            !uiConsumer.startChatButtonState
                ? ButtonFilled(
                    text: 'Start a chat',
                    onPressed: uiConsumer.toggleStartChatButton,
                  )
                : AnimatedOpacity(
                    duration: const Duration(milliseconds: 220),
                    opacity: (uiConsumer.isAgreed && uiConsumer.is18OrOlder)
                        ? 1
                        : 0.5,
                    child: ButtonFilled(
                      text: 'Accept & continue',
                      onPressed: () {

                        registerGuest();
                      },
                    ),
                  ),
          ]),
    );
  }
}
