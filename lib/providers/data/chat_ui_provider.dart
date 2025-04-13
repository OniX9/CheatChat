import 'package:cheat_chat/imports/imports.dart';


class ChatUIProvider with ChangeNotifier {
  // chat Screen
  List<Widget> chatWidgets = [
    ServerChatHint(
      chatHint: 'You\'re chatting with a stranger. SAY YOUR AGE AND GENDER',
    ),
    ChatBubble(
      text:
          "I'm 21 female..................................................................................................................................................",
      isMe: true,
    ),
    ChatBubble(
      text: "I'm 21 male",
      isMe: false,
    ),
    ServerChatHint(
      chatHint: 'Tell the stranger your hobbies...',
    ),
  ];

  void addChatBubble({required String messageText, required bool isMe}) {
    chatWidgets.add(
      ChatBubble(
        text: messageText,
        isMe: isMe,
      ),
    );
    notifyListeners();
  }


  // ChatScreen
  int _chatActionButtonState = 0;
  get chatActionButtonType =>
      ChatActionStateTypes.values[_chatActionButtonState];

  void updateStartChatButtonState() {
    _chatActionButtonState >= 2
        ? _chatActionButtonState = 0
        : _chatActionButtonState += 1;
    notifyListeners();
  }
}

enum ChatActionStateTypes { endChat, youSure, newChat }
