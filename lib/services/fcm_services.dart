// import 'package:safe_cash/imports/imports.dart';
//
// class FCMServices {
//   final _apiService = ApiService();
//   static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final BuildContext context;
//
//   FCMServices(this.context);
//
//   //1. Flutter notifications UI Methods
//   static Future<void> initLocalNotifications() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const InitializationSettings initializationSettings =
//     InitializationSettings(android: androidInitializationSettings);
//
//     await _localNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   static void showNotification(RemoteMessage message) {
//     if (message.notification != null) {
//       _localNotificationsPlugin.show(
//         message.notification.hashCode,
//         message.notification!.title,
//         message.notification!.body,
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'default_channel', // Channel ID
//             'Default', // Channel Name
//             importance: Importance.high,
//             priority: Priority.high,
//             icon: '@mipmap/ic_launcher',
//           ),
//         ),
//       );
//     }
//   }
//
//   //2. FCM Processing Methods
//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     Map<String, dynamic> pushData = message.data;
//     var userProvider = Provider.of<UserProvider>(context, listen: false);
//     var user = userProvider.getUser;
//     var notificationUIProvider = Provider.of<NotificationUIProvider>(context, listen: false);
//
//     notificationUIProvider.setNewNotification(true);
//     // 1. UPDATE USER
//     bool updateUser = pushData['user_update'] == 'true';
//     if (user?.token != null && updateUser) {
//       userProvider.apiUpdateUser(context);
//     }
//
//     showNotification(message);
//   }
//
//   Future<void> initPushNotifications() async {
//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     _firebaseMessaging.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onMessage.listen(handleMessage); // Foreground messages
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMsg);
//   }
//
//   Future<void> updateFCMTokenToServer() async {
//     final fCMToken = await _firebaseMessaging.getToken();
//
//     var userProvider = Provider.of<UserProvider>(context, listen: false);
//     var user = userProvider.getUser;
//
//     // 1. UPDATE
//     if (user?.token != null && fCMToken != null) {
//       print("fCMToken: $fCMToken");
//       _apiService.uploadFCMToken(context, token: user?.token, fcmToken: fCMToken);
//     }
//   }
//
//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     await initPushNotifications();
//     await updateFCMTokenToServer();
//   }
// }
//
// Future<void> handleBackgroundMsg(RemoteMessage message) async {
//   // print('FCM Background Test');
//   // print('Title: ${message.notification?.title}');
//   // print('Body: ${message.notification?.body}');
//   // print('Payload: ${message.data}');
//
//   // Initialize notifications if not already initialized
//   await FCMServices.initLocalNotifications();
//
//   // Show notification
//   FCMServices.showNotification(message);
// }
