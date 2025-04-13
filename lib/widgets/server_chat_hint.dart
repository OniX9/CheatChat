import 'package:cheat_chat/imports/imports.dart';

class ServerChatHint extends StatelessWidget {
  String chatHint;

  ServerChatHint({
    required this.chatHint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          // Computers chat Question hints
          padding: EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 15,
          ),
          child: Text(
            chatHint,
            textAlign: TextAlign.center,
            style: kDescriptionTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
