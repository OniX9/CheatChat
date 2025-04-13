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
      onWillPop: ()async{
        Navigator.of(context).popUntil((route) => route.isFirst);
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: kLinearGradient,
          child: SafeArea(
            maintainBottomViewPadding: false,
            child: ListView(
              physics: NeverScrollableScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              reverse: true,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height-
                          kBottomNavigationBarHeight),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                padding: const EdgeInsets.only(top: 8),
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
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: LogoImage(),
                            ),
                          ],
                        ),
                      ),
                      //PROFILE CONTAINER
                      Expanded(
                        flex: 5,
                        child: ProfileBox(
                          userName: 'Anonymous',
                        ),
                      ),
                      // CHAT CONTAINER
                      Expanded(
                        flex: 20,
                        child: Container(
                          decoration: kRoundedTopBoxDecoration.copyWith(
                              color: Color(0xFFF2F5F5)),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 20,
                                child: ChatWindow(),
                              ),
                              Expanded(
                                flex: 5,
                                child: ChatInputField(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }
}



class ChatWindow extends StatefulWidget {
  const ChatWindow({Key? key}) : super(key: key);

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {

  @override
  Widget build(BuildContext context) {
    ChatUIProvider consumer = Provider.of(context);
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: ListView(
        reverse: true,
        physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
        ),
        children: consumer.chatWidgets.reversed.toList(),
      ),
    );
  }
}