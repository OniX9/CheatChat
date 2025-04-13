import 'package:cheat_chat/imports/imports.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatUIProvider consumer = Provider.of(context);
    return Container(
      height: 80,
      decoration: kRoundedTopBoxDecoration,
      child: Row(
        children: [
          _LeftActionButton(),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 14),
              onSubmitted: (String newMessage) {
                consumer.addChatBubble(
                  messageText: newMessage,
                  isMe: true,
                );
              },
              decoration: InputDecoration(
                hintText: 'Type message here...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
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
    ChatUIProvider consumer = Provider.of<ChatUIProvider>(context);

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
        width: 55,
        height: 50,
        margin: EdgeInsets.all(8),
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
                style: TextStyle(fontSize: 14, color: Colors.white),
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
