import 'package:cheat_chat/imports/imports.dart';

class UserProvider with ChangeNotifier {
  bool _isChatRoomLoading = false;
  final sharedPref = SharedPref();
  final apiServices = ApiService();

  UserModel? _user;

  UserModel? get getUser => _user;
  bool get isChatRoomLoading => _isChatRoomLoading;

  Future<void> loadUserFromPreferences() async {
    Map<String, dynamic>? userData = await sharedPref.getUser();
    if (userData != null) {
      _user = UserModel.fromJson(userData);
    }
    notifyListeners();
  }

  Future<void> setUser(UserModel? newUser) async {
    if (newUser != null) {
      _user = newUser;
      await sharedPref.setUser(newUser.toJson());
      notifyListeners();
    }
  }

  Future<void> clearAll() async {
    _user = null;
    await sharedPref.clearAll();
    notifyListeners();
  }

  // API ViewModels Methods
  /// 1. Create a guest user
  Future<UserModel?> apiCreateUser(BuildContext context) async {
    UserModel? formattedResult;

    String? fcmToken = await FCMServices(context).getFCMToken();
    var newUser = await apiServices.createGuest(
      context,
      fcmToken: fcmToken,
    );

    if (newUser != null) {
      formattedResult = UserModel.fromJson(newUser);
      _user = formattedResult;
      await sharedPref.setUser(newUser);
    }

    notifyListeners();
    return formattedResult;
  }

  /// 2. Get user data
  Future<UserModel?> apiGetUser(BuildContext context) async {
    if (_user == null || _user?.token == null) return null;
    UserModel? formattedResult;

    var newUser = await apiServices.getUser(context, token: _user?.token);
    if (newUser != null) {
      formattedResult = UserModel.fromJson(newUser);
      _user = formattedResult;
      await sharedPref.setUser(newUser);
    }
    notifyListeners();
    return formattedResult;
  }

  /// 3. Update user profile
  Future<UserModel?> apiUpdateUser(BuildContext context,
      {String? name, String? profilePicPath}) async {
    if (_user == null || _user?.token == null) return null;
    UserModel? formattedResult;

    var newUser = await apiServices.updateProfile(
      context,
      token: _user?.token,
      name: name,
      profilePicPath: profilePicPath,
    );

    if (newUser != null) {
      formattedResult = UserModel.fromJson(newUser);
      _user = formattedResult;
      await sharedPref.setUser(newUser);
    }

    return formattedResult;
  }

  /// 4. Start a new chat room
  Future<UserModel?> startChatRoom(BuildContext context) async {
    if (_user == null || _user?.token == null) return null;
    UserModel? formattedResult;

    _isChatRoomLoading = true;
    notifyListeners();
    var newUser = await apiServices.startChatroom(context, token: _user?.token);
    if (newUser != null) {
      formattedResult = UserModel.fromJson(newUser);
      _user = formattedResult;
      debugPrint("CREATE CHATROOM RESPONSE: ${newUser}");
      await sharedPref.setUser(newUser);
    }

    _isChatRoomLoading = false;
    notifyListeners();
    return formattedResult;
  }

  /// 5. End chat
  Future<UserModel?> endChatRoom(BuildContext context) async {
    if (_user == null || _user?.token == null) return null;
    UserModel? formattedResult;

    _isChatRoomLoading = true;
    notifyListeners();
    var newUser = await apiServices.endChatroom(context, token: _user?.token);
    if (newUser != null) {
      formattedResult = UserModel.fromJson(newUser);
      _user = formattedResult;
      await sharedPref.setUser(newUser);
    }

    _isChatRoomLoading = false;
    notifyListeners();
    return formattedResult;
  }
}
