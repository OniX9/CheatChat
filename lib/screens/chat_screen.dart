import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:cheat_chat/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:cheat_chat/globals.dart';
import 'package:cheat_chat/widgets/profile_box.dart';
import 'package:cheat_chat/widgets/logo_image.dart';
import 'package:cheat_chat/widgets/chat_input_field.dart';
import 'package:cheat_chat/screens/onboardingb_screen.dart';

class ChatScreen extends StatefulWidget {
  static const String id = '/ChatScreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var consumer = Provider.of<UIProvider>(context);
    return Scaffold(
      body: Container(
        decoration: kLinearGradient,
        child: SafeArea(
          maintainBottomViewPadding: false,
          child: ListView(
            physics: NeverScrollableScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            reverse: true,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height +
                        MediaQuery.of(context).padding.top -
                        kBottomNavigationBarHeight),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              padding: const EdgeInsets.only(top: 8),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  OnBoardingBScreen.id,
                                  //     (route) {
                                  //   if (route.settings.name == OnBoardingBScreen.id) {
                                  //     return true;
                                  //   } else {
                                  //     return false;
                                  //   }
                                  // },
                                );
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 27,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: LogoImage(),
                          ),
                        ],
                      ),
                    ),
                    //PROFILE CONTAINER
                    Expanded(
                      flex: 5,
                      child: ProfileBox(
                        userName: 'Anonymous',
                      ),
                    ),
                    // CHAT CONTAINER
                    Expanded(
                      flex: 20,
                      child: Container(
                        decoration: kRoundedTopBoxDecoration.copyWith(
                            color: Color(0xFFF2F5F5)),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 20,
                              child: ChatWindow(),
                            ),
                            Expanded(
                              flex: 5,
                              child: ChatInputField(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }
}



class ChatWindow extends StatefulWidget {
  const ChatWindow({Key? key}) : super(key: key);

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {

  @override
  Widget build(BuildContext context) {
    UIProvider consumer = Provider.of(context);
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: ListView(
        reverse: true,
        physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
        ),
        children: consumer.chatWidgets.reversed.toList(),
      ),
    );
  }
}