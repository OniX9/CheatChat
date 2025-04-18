import 'package:cheat_chat/imports/imports.dart';

class ProfileAvatar extends StatelessWidget {
  final bool isOnline;
  final String? imageUrl;

  const ProfileAvatar({required this.isOnline, this.imageUrl, super.key});

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
            url: imageUrl,
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
