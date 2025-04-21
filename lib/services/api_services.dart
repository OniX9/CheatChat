// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as http_dio;
import 'package:cheat_chat/imports/imports.dart';

bool isNavigating = false;

class ApiService {
  bool _isTokenBad = false;

  // late FirebaseAuth auth;
  final _utilities = Utilities();
  final variables = Variables();
  final sharedPref = SharedPref();

  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  http_dio.Dio dio = http_dio.Dio();

  static const API = 'https://cheatchat-backend.onrender.com/v1';
  // static const API = 'http://10.0.2.2:5009/v1'; //LocalHost

  void initialise() {
    var options = BaseOptions(
        baseUrl: API,
        connectTimeout: Duration(milliseconds: 5000),
        receiveTimeout: Duration(milliseconds: 3500),
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        });
    dio.options = options;
  }

  void initiateDio(String? token) {
    if (token == null || token.isEmpty) return;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        var signalHeaders = {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        };
        options.headers.addAll(signalHeaders);
        return handler.next(options);
      },
    ));
  }

  /// ## Handles the response from the server
  /// Transfers user to the SplashScreen,
  /// * if the token is no longer valid
  /// * if the user is logged in on another device
  processRevokedToken(BuildContext context,
      {required Map<String, dynamic> responseData}) {
    _isTokenBad = false;
    var adminUserProvider = Provider.of<UserProvider>(context, listen: false);

    print("_isTokenBad: ${responseData}");

    if (responseData['msg'] == 'Token has been revoked') {
      _utilities.displayToastMessage(
          context, 'Logging out');
      _isTokenBad = true;
    } else if (responseData['msg'] == 'Missing Authorization Header') {
      _utilities.displayToastMessage(
          context, 'Token expired');
      _isTokenBad = true;
    } else if (responseData.containsKey('msg')) {
      // showErrorDialog(context);
      _utilities.displayToastMessage(context, "Something went wrong");
      _isTokenBad = true;
    }

    Future.delayed(Duration(milliseconds: 1800), () {
      if (_isTokenBad == true && isNavigating == false) {
        isNavigating = true;
        adminUserProvider.clearAll();
        Navigator.of(context).pushReplacement(
          PageTransition(
            const OnBoardingScreen(),
            slideFrom: SlideFrom.left,
          ),
        );
        // Delay the navigation to prevent multiple navigations
        Future.delayed(Duration(seconds: 5), () {
          isNavigating = false;
        });
      }
    });
  }

  void handleError(BuildContext context,
      dynamic e, {
        List<int> abortCodes = const [],
        StyledToastPosition errorMsgPosition = StyledToastPosition.top,
      }) {
    if (e is DioException) {
      var message;
      var errData = e.response?.data;
      bool isAbortError = abortCodes.contains(e.response?.statusCode);
      // Checks
      if (errData == null) {
        // 1. is null
        return;
      } else if (!(errData is Map)) {
        // 2. is not a Map
        message = "Service unavailable, try again later.";
      } else if (isAbortError && errData.containsKey('message')) {
        // 3. is an abort from backend service
        message = errData['message'];
      } else {
        // just print exception.
        debugPrint('An error occurred: ${errData}');
      }

      if (message != null) {
        _utilities.displayToastMessage(
          context,
          message,
          backgroundColor: Colors.red,
          position: errorMsgPosition,
        );
      }

      if (errData is Map) {
        processRevokedToken(context, responseData: e.response?.data);
      }
    } else {
      _utilities.displayToastMessage(context, e.toString(),
          backgroundColor: Colors.red, position: errorMsgPosition);
    }
  }

  // ***USER***

  Future<Map<String, dynamic>?> createGuest(BuildContext context) async {
    try {
      var response = await dio.post(
        '$API/guest-register',
      );
      print("Guest user: ${response.data}");
      return response.data;
    } catch (e) {
      // ERROR HANDLING
      handleError(context, e, abortCodes: [409, 400]);
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUser(BuildContext context,
      {required String? token}) async {
    initiateDio(token);
    try {
      var response = await dio.get('$API/user');
      return response.data;
    } catch (e) {
      // ERROR HANDLING
      handleError(context, e, abortCodes: [404]);
      return null;
    }
  }

  Future updateProfile(
      BuildContext context, {
        required String? token,
        String? name,
        String? email,
        String? phoneNo,
        String? referredBy,
        String? profilePicPath,
      }) async {
    initiateDio(token);

    try {
      FormData formData = FormData.fromMap({
        'name': name,
        if (profilePicPath != null)
          'profile_pic': await MultipartFile.fromFile(profilePicPath),
      });

      var response = await dio.put(
        '$API/user',
        data: formData,
      );

      return response.data;
    } catch (e) {
      // ERROR HANDLING
      handleError(context, e,
          abortCodes: [404], errorMsgPosition: StyledToastPosition.top);
      return null;
    }
  }

  // ***CHATROOM***

  Future<Map<String, dynamic>?> startChatroom(BuildContext context,
      {required String? token}) async {
    initiateDio(token);
    try {
      var response = await dio.post('$API/chatroom');
      return response.data;
    } catch (e) {
      // ERROR HANDLING
      handleError(context, e, abortCodes: [404]);
      return null;
    }
  }

  Future<Map<String, dynamic>?> endChatroom(BuildContext context,
      {required String? token}) async {
    initiateDio(token);
    try {
      var response = await dio.delete('$API/chatroom');
      return response.data;
    } catch (e) {
      // ERROR HANDLING
      handleError(context, e, abortCodes: [404]);
      return null;
    }
  }

  Future uploadFCMToken(BuildContext context,
      {required String? token, required String fcmToken}) async {
    initiateDio(token);
    Map<String, dynamic> data = {
      "fcm_token": fcmToken,
    };

    try {
      var response = await dio.put(
        '$API/user/fcm-token',
        data: data,
      );
      return response.data;
    } catch (e) {
      // ERROR HANDLING
      handleError(context, e);
      return null;
    }
  }

  // ***CHAT***

  Future<Map<String, dynamic>?> getOtherUser(BuildContext context,
      {required String? token}) async {
    initiateDio(token);
    try {
      var response = await dio.get('$API/chat/other-user-details');
      return response.data;
    } catch (e) {
      // ERROR HANDLING
      handleError(context, e, abortCodes: [404]);
      return null;
    }
  }

  Future<Map<String, dynamic>?> refreshOnlineStatus(BuildContext context,
      {required String? token}) async {
    initiateDio(token);
    try {
      var response = await dio.get('$API/chat/last-online');
      return response.data;
    } catch (e) {
      // ERROR HANDLING
      handleError(context, e);
      return null;
    }
  }

  Future<Map<String, dynamic>?> refreshTypingStatus(BuildContext context,
      {required String? token}) async {
    initiateDio(token);
    try {
      var response = await dio.get('$API/chat/last-typing');
      return response.data;
    } catch (e) {
      // ERROR HANDLING
      handleError(context, e);
      return null;
    }
  }

}
