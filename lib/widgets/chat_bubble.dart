import 'package:cheat_chat/imports/imports.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String text;

  const ChatBubble({
    Key? key,
    required this.isMe,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 350),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
                color: isMe ? Colors.blue[800] : Colors.white,
                borderRadius: isMe
                    ? BorderRadius.only(
                  topRight: Radius.circular(18),
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                )
                    : BorderRadius.only(
                  topRight: Radius.circular(18),
                  topLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                )),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
