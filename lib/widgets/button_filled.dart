import 'package:cheat_chat/imports/imports.dart';
import 'package:cheat_chat/widgets/gradient_text.dart';

class ButtonFilled extends StatelessWidget {
  final String text;
  final Color? textColor;
  final TextOverflow? textOverflow;
  final TextStyle? textStyle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? gradientButtonTextColor;
  final double? width;
  final double? height;
  final Widget? leading;
  final Widget? trailing;
  final double? trailingWidth;
  final double? borderRadius;
  final BorderSide? borderSide;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final Gradient gradient;
  final bool enableGradient;
  final bool enableTextGradient;
  final EdgeInsetsGeometry margin;

  const ButtonFilled({
    super.key,
    this.leading,
    this.trailing,
    this.textOverflow,
    this.textStyle,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.gradientButtonTextColor = Colors.white,
    this.backgroundColor = kAppBlue,
    this.borderSide,
    this.height = 50,
    this.fontSize = 14,
    this.borderRadius = 30,
    this.trailingWidth = 20,
    this.enableGradient = false,
    this.width = double.maxFinite,
    this.enableTextGradient = false,
    this.fontWeight = FontWeight.w500,
    this.gradient = const LinearGradient(
      colors: [kAppGreenMain, kAppGreenDark],
    ),
    this.margin = const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: enableGradient ? gradient : null,
          color: enableGradient ? null : backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
              side: borderSide ?? BorderSide.none,
            ),
          ),
          onPressed: onPressed,
          child: Container(
            height: 35,
            width: width,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) leading!,
                if (leading != null) SizedBox(width: 20),
                enableTextGradient
                    ? GradientText(
                  text,
                  overflow: textOverflow,
                  style: textStyle ?? TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ):
                Text(text,
                  overflow: textOverflow,
                  style: textStyle ?? TextStyle(
                    fontSize: fontSize,
                    fontFamily: Fonts.nunitoSans,
                    fontWeight: fontWeight,
                    color: enableGradient? gradientButtonTextColor: textColor,
                  ),
                ),
                if (trailing != null) SizedBox(width: trailingWidth),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
