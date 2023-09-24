import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  bool isMe;
  String text;

  ChatBubble({
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
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
                color: isMe ? Colors.blue[800] : Colors.white,
                borderRadius: isMe
                    ? BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
                    : BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 16,
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