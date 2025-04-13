import 'package:cheat_chat/imports/imports.dart';

class OnBoardingUIProvider with ChangeNotifier {
  bool _startChatButtonState = false;
  bool get startChatButtonState => _startChatButtonState;

  void toggleStartChatButton() {
    _startChatButtonState = !_startChatButtonState;
    notifyListeners();
  }

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
