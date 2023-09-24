import 'package:flutter/material.dart';
import 'package:cheat_chat/globals.dart';

class ServerChatHint extends StatelessWidget {
  String chatHint;
  bool isTyping;

  ServerChatHint({
    required this.chatHint,
    required this.isTyping,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          // Computers chat Question hints
          padding: EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 15,
          ),
          child: Text(
            chatHint,
            textAlign: TextAlign.center,
            style: kDescriptionTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Visibility(
          // when text input onChanged is triggered on the
          // other parties TextField, visiblity should be true.
          visible: isTyping,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Stranger is typing...',
                style: kDescriptionTextStyle.copyWith(
                  fontSize: 14,
                  color: Colors.blueGrey[200],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
