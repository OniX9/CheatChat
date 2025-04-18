import 'package:cheat_chat/imports/imports.dart';

/// This function save or gets a persistent UID for the user in a file.
Future<String> perstitentUID({required String user_id, bool overWrite = false}) async {

  final status = await Permission.storage.request();
  if (!status.isGranted) {
    throw Exception('Storage permission not granted');
  }

  // Use external storage directory that survives uninstall
  final dir = Directory('/storage/emulated/0/.cheatchat');
  if (!(await dir.exists())) {
    await dir.create(recursive: true);
  }

  final file = File('${dir.path}/cc.uid');

  if (!await file.exists() || overWrite) {
    final uid = user_id;
    await file.writeAsString(uid);
    return uid;
  } else {
    return await file.readAsString();

  }
}
