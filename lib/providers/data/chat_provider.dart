import 'package:cheat_chat/imports/imports.dart';

class ChatProvider with ChangeNotifier {

  final utils = Utilities();
  final sharedPref = SharedPref();
  final apiServices = ApiService();

  // API ViewModels Methods
  // 1. Refresh Typing
  bool _isTypingLock = false;
  Future<void> apiRefreshTypingStatus(BuildContext context,
      {String? token}) async {
    if (token == null) {
      utils.displayToastMessage(context, "No token");
      return;
    }

    if (!_isTypingLock) {
      _isTypingLock = true;
      debugPrint("Typing lock deactivated");
      Future.delayed(const Duration(seconds: 2), () {
        _isTypingLock = false;
        notifyListeners();
      });
      await apiServices.refreshTypingStatus(context, token: token);
    }
  }

  // 2. Refresh Online status
  Timer? _onlineStatusTimer;
  void apiStartOnlinePolling(BuildContext context, {String? token}) async {
    if (token == null) {
      utils.displayToastMessage(context, "No token");
      return;
    }

    _onlineStatusTimer = Timer.periodic(const Duration(seconds: 25), (timer) async {
      await apiServices.refreshOnlineStatus(context, token: token);
    });
  }

  void apiStopOnlinePolling() {
    if (_onlineStatusTimer != null) {
      _onlineStatusTimer?.cancel();
      _onlineStatusTimer = null;
    }
  }
}
