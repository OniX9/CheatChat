import 'package:cheat_chat/imports/imports.dart';

class InternetCheckProvider extends ChangeNotifier {
  late StreamSubscription<InternetConnectionStatus> _subscription;
  bool _isOnline = true;

  bool get isOnline => _isOnline;

  init() {
    _subscription = InternetConnectionChecker.instance.onStatusChange.listen((status) {
      final hasConnection = status == InternetConnectionStatus.connected;
      if (hasConnection != _isOnline) {
        _isOnline = hasConnection;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
