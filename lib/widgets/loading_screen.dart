import 'package:cheat_chat/imports/imports.dart';

class LoadingScreen extends StatelessWidget {
  final Color color;
  const LoadingScreen({super.key, this.color = kAppGreenMain});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: color,
        size: 30,
      ),
    );
  }
}