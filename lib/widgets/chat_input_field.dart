import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cheat_chat/providers/ui_provider.dart';
import 'package:cheat_chat/globals.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIProvider consumer = Provider.of(context);
    return Container(
      decoration: kRoundedTopBoxDecoration,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _LeftActionButton(),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                right: 25,
                bottom: 20,
              ),
              child: TextField(
                style: TextStyle(fontSize: 18),
                onSubmitted: (String newMessage) {
                  consumer.addChatBubble(
                    messageText: newMessage,
                    isMe: true,
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Type message here...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  // suffixIcon: IconButton(
                  //   onPressed: (){
                  //     consumer.addChatBubble(
                  //       messageText: newMessage,
                  //       isMe: true,
                  //     );
                  //   },
                  //   icon: Icon(
                  //     Icons.send,
                  //     color: Colors.grey[400],
                  //   ),
                  // ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftActionButton extends StatelessWidget {
  _LeftActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIProvider consumer = Provider.of<UIProvider>(context);

    Widget chatButtonContent() {
      var chatActionButtonType = consumer.chatActionButtonType;
      late String label;
      late Color? buttonColor;

      switch (chatActionButtonType) {
        case ChatActionStateTypes.endChat:
          label = 'End chat?';
          buttonColor = Colors.red;
          break;
        case ChatActionStateTypes.youSure:
          label = 'You sure?';
          buttonColor = Colors.red;
          break;
        case ChatActionStateTypes.newChat:
          label = 'New chat';
          buttonColor = Colors.blue[900];
          break;
      }
      return Container(
        width: 70,
        height: 60,
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              constraints: BoxConstraints(maxWidth: 40),
              child: Text(
                label,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        consumer.updateStartChatButtonState();
        print(consumer.chatActionButtonType);
      },
      child: chatButtonContent(),
    );
  }
}
