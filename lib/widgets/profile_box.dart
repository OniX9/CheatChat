import 'package:cheat_chat/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:cheat_chat/globals.dart';
import 'package:provider/provider.dart';

class ProfileBox extends StatelessWidget {
  String userName;

  ProfileBox({
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UIProvider consumer = Provider.of<UIProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 50),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileAvatar(true),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chatting with', style: kDescriptionTextStyle),
                    SizedBox(height: 4),
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: consumer.chatActionButtonType ==
                  ChatActionButtonTypes.newChat ? 1.0 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 70,
                height: 60,
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 40),
                      child: Text(
                        'New chat?',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  bool isOnline;
  String imageUri;

  ProfileAvatar(this.isOnline, {this.imageUri='', super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 30,
            child: null,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Visibility(
              visible: isOnline,
              child: Container(
                //Online Status green dot
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.cyan[600],
                    shape: BoxShape.circle,
                  ),
                  width: 12,
                  height: 12,
                  child: null,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
