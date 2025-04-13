import 'package:cheat_chat/imports/imports.dart';

class ProfileContainer extends StatelessWidget {
  final String? url;
  final double radius;
  final String placeholder;

  const ProfileContainer({
    this.radius = 42,
    this.url,
    this.placeholder = 'assets/images/profile_placeholder.png',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (url != null && url!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url!,
        imageBuilder: (context, imageProvider) => Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Image.asset(
          placeholder,
          fit: BoxFit.cover,
          width: radius,
          height: radius,
        ),
        errorWidget: (context, url, error) => !kDebugMode ? Image.asset(
          placeholder,
          fit: BoxFit.cover,
          width: radius > 10 ? radius - 10 : 10,
          height: radius,
        ): Icon(
          Icons.broken_image,
          size: radius > 10 ? radius - 10 : 10,
          color: Colors.red,
        ),
      );
    } else {
      return Image.asset(
        placeholder,
        fit: BoxFit.cover,
        width: radius,
        height: radius,
      );
    }
  }
}
