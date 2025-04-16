import 'package:cheat_chat/imports/imports.dart';

class OnBoardingUIProvider with ChangeNotifier {
  bool _isAgreed = false;
  bool _is18OrOlder = false;
  bool _startChatButtonState = false;

  bool get isAgreed => _isAgreed;
  bool get is18OrOlder => _is18OrOlder;
  bool get startChatButtonState => _startChatButtonState;

  void toggleStartChatButton() {
    _startChatButtonState = !_startChatButtonState;
    notifyListeners();
  }
  void toggle18OrOlder(bool value) {
    _is18OrOlder = value;
    notifyListeners();
  }
  void toggleAgreed(bool value) {
    _isAgreed = value;
    notifyListeners();
  }
}
