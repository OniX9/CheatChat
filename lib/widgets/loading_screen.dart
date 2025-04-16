import 'package:cheat_chat/imports/imports.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: kAppGreenMain,
      ),
    );
  }
}