import 'package:cheat_chat/imports/imports.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSendMessage;

  const ChatInputField({
    Key? key,
    this.controller,
    this.onSendMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatProvider chatConsumer = Provider.of<ChatProvider>(context);
    ChatUIProvider chatUIConsumer = Provider.of<ChatUIProvider>(context);
    var userConsumer = Provider.of<UserProvider>(context);
    var user = userConsumer.getUser;

    return Container(
      height: 80,
      decoration: kRoundedTopBoxDecoration,
      child: Row(
        children: [
          _LeftActionButton(),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 14),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              autofocus: true,
              maxLines: null,
              onChanged: (_) {
                if (chatUIConsumer.chatButtonType != ChatButtonTypes.newChat) {
                  chatConsumer.apiRefreshTypingStatus(
                    context,
                    token: user?.token,
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'Type message here...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            color: kAppBlue,
            icon: const Icon(Icons.send, size: 30),
            padding: const EdgeInsets.all(10),
            // shape: const CircleBorder(),
            onPressed: onSendMessage,
          ),
        ],
      ),
    );
  }
}

class _LeftActionButton extends StatefulWidget {
  _LeftActionButton({Key? key}) : super(key: key);

  @override
  State<_LeftActionButton> createState() => _LeftActionButtonState();
}

class _LeftActionButtonState extends State<_LeftActionButton> {
  updateChatButtonType() {
    var chatUIConsumer = Provider.of<ChatUIProvider>(context, listen: false);
    var user = Provider.of<UserProvider>(context, listen: false).getUser;
    if (user != null) {
      // Set Chat button to NewChat, if user has already ended chat.
      ChatButtonTypes chatButtonType = user.searching == true
          ? ChatButtonTypes.newChat
          : ChatButtonTypes.endChat;
      chatUIConsumer.updateChatButtonType(chatButtonType);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateChatButtonType();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utilities();
    ChatUIProvider uiConsumer = Provider.of<ChatUIProvider>(context);
    UserProvider userConsumer = Provider.of<UserProvider>(context);
    OtherUserProvider otherUserConsumer = Provider.of<OtherUserProvider>(context);
    bool isOnline = Provider.of<InternetCheckProvider>(context).isOnline;

    var chatActionButtonType = uiConsumer.chatButtonType;
    late String label;
    late Color? buttonColor;

    switch (chatActionButtonType) {
      case ChatButtonTypes.endChat:
        label = 'End chat?';
        buttonColor = Colors.red;
        break;
      case ChatButtonTypes.youSure:
        label = 'You sure?';
        buttonColor = Colors.red;
        break;
      case ChatButtonTypes.newChat:
        label = 'New chat';
        buttonColor = Colors.blue[900];
        break;
    }

    return GestureDetector(
      onTap: () {
        if (isOnline) {
          startOrEndChat(context);
        } else {
          utils.displayToastMessage(context, "Check your internet connection");
        }
      },
      child: Container(
        width: 55,
        height: 50,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Align(
          alignment: Alignment.center,
          child: userConsumer.isChatRoomLoading || otherUserConsumer.isLoading
              ? const LoadingScreen(color: Colors.white)
              : Padding(
            padding: const EdgeInsets.only(left: 4),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 40),
              child: Text(
                label,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  startOrEndChat(BuildContext context) {
    ChatUIProvider uiConsumer =
        Provider.of<ChatUIProvider>(context, listen: false);
    UserProvider dataConsumer =
        Provider.of<UserProvider>(context, listen: false);
    OtherUserProvider otherUserConsumer =
        Provider.of<OtherUserProvider>(context, listen: false);
    UserProvider userConsumer =
        Provider.of<UserProvider>(context, listen: false);
    var user = userConsumer.getUser;


    if (dataConsumer.isChatRoomLoading) return;
    if (uiConsumer.chatButtonType == ChatButtonTypes.newChat) {
      dataConsumer.startChatRoom(context).then((result) async {
        if (result != null) {
          debugPrint("Start chat");
          await otherUserConsumer.apiGetUser(context, token: user?.token);
          uiConsumer.toogleChatButton();
        }
      });
    } else if (uiConsumer.chatButtonType == ChatButtonTypes.endChat) {
      uiConsumer.toogleChatButton();
    } else if (uiConsumer.chatButtonType == ChatButtonTypes.youSure) {
      dataConsumer.endChatRoom(context).then((result) {
        if (result != null) {
          debugPrint("End chat");
          uiConsumer.toogleChatButton();
        }
      });
    }
  }
}
