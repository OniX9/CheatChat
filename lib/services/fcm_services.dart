import 'package:cheat_chat/imports/imports.dart';

class FCMServices {
  final _apiService = ApiService();
  final UserProvider userProvider;
  final OtherUserProvider otherUserProvider;

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final BuildContext context;

  FCMServices(this.context)
      : userProvider = Provider.of<UserProvider>(context, listen: false),
      otherUserProvider = Provider.of<OtherUserProvider>(context, listen: false);

  //1. Flutter notifications UI Methods
  static Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _localNotificationsPlugin.initialize(initializationSettings);
  }

  static void showNotification(RemoteMessage message) {
    if (message.notification != null) {
      _localNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel', // Channel ID
            'Default', // Channel Name
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  //2. FCM Processing Methods
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    Map<String, dynamic> pushData = message.data;
    var user = userProvider.getUser;

    // 1. UPDATE USER
    bool updateUser = pushData['user_update'] == 'true';
    if (user?.token != null && updateUser) {
      userProvider.apiGetUser(context);
    }
    // 2. Update Other User Details
    bool updateOtherUser = pushData['update_other_user'] == 'true';
    if (user?.token != null && updateOtherUser) {
      otherUserProvider.apiGetUser(context, token: user?.token);
      print("Update other user Passed");
    }
    // 3. Is Other User Typing
    bool LastTypingString = pushData['last_typing'] != null;

    if (user?.token != null && LastTypingString) {
      DateTime lastTyping = DateTime.parse(pushData['last_typing']);
      otherUserProvider.refreshIsTyping(lastTyping: lastTyping);
    }

    // 4. Get Other User Online Status
    bool LastOnlineString = pushData['last_online'] != null;

    if (user?.token != null && LastOnlineString) {
      DateTime lastOnline = DateTime.parse(pushData['last_online']);
      otherUserProvider.refreshOnlineStatus(lastOnline: lastOnline);
    }

    showNotification(message);
  }

  Future<void> initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessage); // Foreground messages
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMsg);
  }

  Future<void> updateFCMTokenToServer() async {
    final fCMToken = await _firebaseMessaging.getToken();

    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var user = userProvider.getUser;

    // 1. UPDATE FCMToken
    if (user?.token != null && fCMToken != null) {
      debugPrint("fCMToken: $fCMToken");
      _apiService.uploadFCMToken(context,
          token: user?.token, fcmToken: fCMToken);
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    await initPushNotifications();
    await updateFCMTokenToServer();
  }
}

Future<void> handleBackgroundMsg(RemoteMessage message) async {
  // print('FCM Background Test');
  // print('Title: ${message.notification?.title}');
  // print('Body: ${message.notification?.body}');
  // print('Payload: ${message.data}');

  // Initialize notifications if not already initialized
  await FCMServices.initLocalNotifications();

  // Show notification
  FCMServices.showNotification(message);
}
