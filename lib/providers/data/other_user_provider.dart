import 'package:cheat_chat/imports/imports.dart';

class OtherUserProvider with ChangeNotifier {
  bool _isLoading = false;
  OtherUserModel? _otherUser;

  final utils = Utilities();
  final sharedPref = SharedPref();
  final apiServices = ApiService();


  bool get isLoading => _isLoading;
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
    print(newUser);
    if (newUser != null) {
      formattedResult = OtherUserModel.fromJson(newUser);
      print("Test");
      _otherUser = formattedResult;
    }

    _isLoading = false;
    notifyListeners();
    return formattedResult;
  }

  Future<void> clear() async {
    _otherUser = null;
    notifyListeners();
  }
}