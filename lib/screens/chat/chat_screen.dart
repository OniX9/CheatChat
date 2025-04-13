import 'package:cheat_chat/imports/imports.dart';

class ChatScreen extends StatefulWidget {
  static const String id = '/ChatScreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var consumer = Provider.of<ChatUIProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return true;
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: kLinearGradient,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.only(top: 8, left: 12),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            OnBoardingScreen.id,
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                      LogoImage(),
                      SizedBox(width: 50),
                    ],
                  ),
                  ProfileBox(userName: "userName"),
                  ChatWindow(),
                ],
              ),
            ),
          )),
    );
  }
}

//***SCREEN-ONLY WIDGETs***
// 1.
class ProfileBox extends StatelessWidget {
  final String userName;

  const ProfileBox({
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ChatUIProvider consumer = Provider.of<ChatUIProvider>(context);

    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity:
                consumer.chatActionButtonType == ChatActionStateTypes.newChat
                    ? 1.0
                    : 0,
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
    );
  }
}

// 2.
class ProfileAvatar extends StatelessWidget {
  final bool isOnline;
  final String imageUri;

  const ProfileAvatar(this.isOnline, {this.imageUri = '', super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 17),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ProfileContainer(
            url: null,
            radius: 53,
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

// 3.
class ChatWindow extends StatefulWidget {
  const ChatWindow({Key? key}) : super(key: key);

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  @override
  Widget build(BuildContext context) {
    ChatUIProvider consumer = Provider.of(context);
    return Expanded(
      child: Container(
        decoration: kRoundedTopBoxDecoration.copyWith(
          color: Color(0xFFF3F6F6),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: ListView(
                reverse: true,
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: consumer.chatWidgets.reversed.toList(),
              ),
            ),
            Visibility(
              // when text input onChanged is triggered on the
              // other parties TextField, visiblity should be true.
              visible: true,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding:
                const EdgeInsets.symmetric(horizontal: 13.0, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'Stranger is typing...',
                  style: kDescriptionTextStyle.copyWith(
                    fontSize: 14,
                    color: Colors.blueGrey[200],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ChatInputField(),
            ),
          ],
        ),
      ),
    );
  }
}
