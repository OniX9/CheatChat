import 'package:cheat_chat/imports/imports.dart';


class ChatUIProvider with ChangeNotifier {
  int _chatActionButtonState = 0;
  get chatButtonType => ChatButtonTypes.values[_chatActionButtonState];

  void toogleChatButton() {
    _chatActionButtonState >= 2
        ? _chatActionButtonState = 0
        : _chatActionButtonState += 1;
    notifyListeners();
  }

  void updateChatButtonType(ChatButtonTypes type) {
    List<ChatButtonTypes> typeList = ChatButtonTypes.values;
    int typeIndex = typeList.indexWhere((ChatButtonTypes values) => values == type);
    _chatActionButtonState = typeIndex;
    notifyListeners();
  }
}

enum ChatButtonTypes { endChat, youSure, newChat }
