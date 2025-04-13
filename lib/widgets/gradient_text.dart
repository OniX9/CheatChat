import 'package:cheat_chat/imports/imports.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const GradientText(
      this.text, {
        this.style,
        this.overflow,
        this.textAlign,
        this.gradient = const LinearGradient(
          colors: [kAppGreenMain, kAppGreenDark],
        ),
      });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: style,
        overflow: overflow,
      ),
    );
  }
}
