import 'package:cheat_chat/imports/imports.dart';

class ServerChatHint extends StatelessWidget {
  final String chatHint;

  const ServerChatHint({
    required this.chatHint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Computers chat Question hints
      padding: const EdgeInsets.fromLTRB(50, 30, 50, 10),
      child: Text(
        chatHint,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Color(0xFF9CA6AE),
        ),
      ),
    );
  }
}
