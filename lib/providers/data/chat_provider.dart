import 'package:cheat_chat/imports/imports.dart';

class ChatProvider with ChangeNotifier {
  final utils = Utilities();
  final sharedPref = SharedPref();
  final apiServices = ApiService();


  // API ViewModels Methods
  // 1. Refresh Typing
  bool isTypingLock = false;
  Future<void> apiRefreshTypingStatus(BuildContext context,
      {String? token}) async {
    if (token == null) {
      utils.displayToastMessage(context, "No token");
      return;
    }

    if (!isTypingLock) {
      isTypingLock = true;
      debugPrint("Typing lock deactivated");
      await apiServices.refreshTypingStatus(context, token: token);
      Future.delayed(const Duration(seconds: 2), (){
        isTypingLock = false;
      });
    }
  }
}