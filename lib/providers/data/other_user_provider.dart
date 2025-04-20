import 'package:cheat_chat/imports/imports.dart';

class OtherUserProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isOnline = false;
  bool _isTyping = false;
  OtherUserModel? _otherUser;

  final utils = Utilities();
  final sharedPref = SharedPref();
  final apiServices = ApiService();


  bool get isLoading => _isLoading;
  bool get isOnline => _isOnline;
  bool get isTyping => _isTyping;
  OtherUserModel? get getUser => _otherUser;

  // API ViewModels Methods
  // 1. Create a guest user
  Future<OtherUserModel?> apiGetUser(BuildContext context, {String? token}) async {
    if (token == null) {
      utils.displayToastMessage(context, "No token");
      return null;
    }
    OtherUserModel? formattedResult;

    _isLoading = true;
    notifyListeners();
    var newUser = await apiServices.getOtherUser(context, token: token);
    if (newUser != null) {
      formattedResult = OtherUserModel.fromJson(newUser);
      _otherUser = formattedResult;
    }

    _isLoading = false;
    notifyListeners();
    return formattedResult;
  }

  // 2. Update online status
  Timer? _isOnlineTimer ;
  /// Refreshes online status(isOnline) countdown, based on last seen time
  Future<void> refreshOnlineStatus({required DateTime lastOnline}) async {
    int maxOfflineDelay = 8;

    int seconds_diff = DateTime.now().difference(lastOnline).inSeconds;
    // If seconds is negative, return 0,
    // A bug fix against the server being 2 seconds ahead;
    seconds_diff = seconds_diff >= 0 ? seconds_diff : 0;

    if (seconds_diff <= maxOfflineDelay) {
      _isOnline = true;
      if (_isOnlineTimer != null) _isOnlineTimer?.cancel();
      _isOnlineTimer = Timer(Duration(seconds: maxOfflineDelay-seconds_diff), () {
        _isOnline = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  // 3. Update typing status
  Timer? _isTypingTimer;
  /// Refreshes typing status (isTyping) countdown, based on last typing time
  Future<void> refreshIsTyping({required DateTime lastTyping}) async {
    int maxOfflineDelay = 5;

    int seconds_diff = DateTime.now().difference(lastTyping).inSeconds;
    // If seconds is negative, return 0.
    // A bug fix against the server being 2 seconds ahead;
    seconds_diff = seconds_diff >= 0 ? seconds_diff : 0;

    if (seconds_diff <= maxOfflineDelay) {
      _isTyping = true;
      if (_isTypingTimer != null) _isTypingTimer?.cancel();
      _isTypingTimer = Timer(Duration(seconds: maxOfflineDelay-seconds_diff), () {
        _isTyping = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  Future<void> clear() async {
    _otherUser = null;
    notifyListeners();
  }
}