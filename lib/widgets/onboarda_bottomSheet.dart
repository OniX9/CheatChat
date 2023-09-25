import 'package:cheat_chat/screens/chat_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cheat_chat/providers/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:cheat_chat/globals.dart';
import 'package:cheat_chat/widgets/custom_checkbox.dart';

class OnBoardingABottomSheet extends StatefulWidget {
  void Function() startchatbuttonCallBack;
  double bottomSheetAnimatedHeight;

  OnBoardingABottomSheet({
    Key? key,
    required this.startchatbuttonCallBack,
    required this.bottomSheetAnimatedHeight,
  }) : super(key: key);

  @override
  State<OnBoardingABottomSheet> createState() => _OnBoardingABottomSheetState();
}

class _OnBoardingABottomSheetState extends State<OnBoardingABottomSheet> {

  @override
  Widget build(BuildContext context) {
    var consumer = Provider.of<UIProvider>(context);
    return Container(
      height: widget.bottomSheetAnimatedHeight,
      decoration: kRoundedTopBoxDecoration,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
        physics: NeverScrollableScrollPhysics(),
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
          Visibility(
            visible: !consumer.startChatButtonState,
            child: Padding(
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
          ),
          Visibility(
            visible: consumer.startChatButtonState,
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: CustomCheckbox(
                    onChanged: (bool isChecked) {
                      print(isChecked);
                    },
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'I am 18 or older',
                  style: kAgreementTextStyle.copyWith(height: 0),
                ),
              ],
            ),
          ),
          Visibility(
            visible: consumer.startChatButtonState,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: CustomCheckbox(
                    onChanged: (bool isChecked) {},
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
          ),
          Visibility(
            visible: consumer.startChatButtonState,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'images/onboard_screen/crocodile_2.png',
              ),
            ),
          ),
          Visibility(
            visible: consumer.startChatButtonState,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 15),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    ChatScreen.id,
                    (route) {
                      return route.settings.name == ChatScreen.id
                          ? true
                          : false;
                    },
                  );
                },
                color: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Column(
                  children: [
                    SizedBox(width: double.maxFinite),
                    Text(
                      'Accept & continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
