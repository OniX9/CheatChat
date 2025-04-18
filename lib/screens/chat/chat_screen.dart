import 'package:cheat_chat/imports/imports.dart';
import 'package:cheat_chat/widgets/profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = '/ChatScreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false).getUser;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user != null) {
        Provider.of<OtherUserProvider>(context, listen: false)
            .apiGetUser(context, token: user.token);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var otherUserConsumer = Provider.of<OtherUserProvider>(context);
    var otherUser = otherUserConsumer.getUser;
    return Scaffold(
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
                        Navigator.pop(context);
                        print("ProfileURL: ${otherUser?.profileUrl}");
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
                ProfileBox(
                  userName: otherUser?.name ?? "",
                  imageUrl: otherUser?.profileUrl,
                ),
                ChatWindow(),
                // ChatInputField(),
              ],
            ),
          ),
        ));
  }
}

//***SCREEN-ONLY WIDGETs***
// 1.
class ProfileBox extends StatelessWidget {
  final String userName;
  final String? imageUrl;

  const ProfileBox({
    required this.userName,
    required this.imageUrl,
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
          ProfileAvatar(isOnline: true, imageUrl: imageUrl),
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
                consumer.chatButtonType == ChatButtonTypes.newChat ? 1.0 : 0,
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

// 3.
class ChatWindow extends StatefulWidget {
  const ChatWindow({Key? key}) : super(key: key);

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  UserModel? user;
  Stream<QuerySnapshot>? _stream;
  late StreamSubscription<QuerySnapshot> _subscription;
  final firestore = FirebaseFirestore.instance;

  static const short = ShortUuid();
  final apiService = ApiService();
  final utils = Utilities();
  final messageTextController = TextEditingController();

  initFSStream() {
    var authUserConsumer = Provider.of<UserProvider>(context, listen: false);
    var authUser = authUserConsumer.getUser;
    String? chatroom_id = authUser?.chatRoom;

    if (chatroom_id != null) {
      _stream = firestore
          .collection("chatrooms/${chatroom_id}/chats")
          .orderBy("sent_on", descending: true)
          .snapshots();

      _subscription = _stream!.listen((snapshot) {
        setState(() {
          // No need to assign the stream again, it's already stored.
        });
      });
    }
  }

  @override
  initState() {
    initFSStream();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userConsumer = Provider.of<UserProvider>(context);
    user = userConsumer.getUser;

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
              child: user?.chatRoom != null
                  ? StreamBuilder<QuerySnapshot>(
                      stream: _stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: LoadingScreen(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              '',
                              // 'No chats',
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        } else {
                          return Center(
                            child: ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc =
                                    snapshot.data!.docs[index];
                                var msg = ChatModel.fromDocSnapshot(doc);
                                bool isMe = user?.uid == msg.uid;

                                return ChatBubble(
                                  text: msg.text ?? '',
                                  isMe: isMe,
                                );
                              },
                            ),
                          );
                        }
                      },
                    )
                  : Center(
                      child: Text(""),
                    ),
            ),
            Visibility(
              // when text input onChanged is triggered on the
              // other parties TextField, visiblity should be true.
              visible: false,
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
              child: ChatInputField(
                controller: messageTextController,
                onSendMessage: () {
                  sendMessage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage() {
    final chatUIConsumer = Provider.of<ChatUIProvider>(context, listen: false);
    final authUserProvider = Provider.of<UserProvider>(context, listen: false);
    var authUser = authUserProvider.getUser;

    String? uid = authUser?.uid;
    String? chatroom_id = authUser?.chatRoom;
    String messageText = messageTextController.text;

    // CHECKS
    // 1. Chat already ended
    print("Shouldn't send1");
    if (authUser?.searching == true) {
      print("Shouldn't send2");
      utils.displayToastMessage(
        context,
        'Chat ended, tap "New Chat"',
        position: StyledToastPosition.right,
        animation: StyledToastAnimation.slideFromBottom,
        backgroundColor: kAppBlue.withBlue(100),
        textColor: Colors.grey[200],
      );
      return;
    }

    if (uid != null && messageText.isNotEmpty) {
      String id = short.generate();
      final userCollection =
          firestore.collection("chatrooms/${chatroom_id}/chats");

      ChatModel chat = ChatModel(
        id: id,
        uid: uid,
        text: messageText,
        sentOn: FieldValue.serverTimestamp(),
      );
      userCollection.doc(id).set(chat.toJson());
      messageTextController.clear();
    }
  }
}
