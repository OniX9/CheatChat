import 'package:cheat_chat/imports/imports.dart';

class CustomTextField extends StatefulWidget {
  final readOnly;
  final String? initialValue;
  final TextStyle? style;
  final int? maxLines;
  final Color? borderColor;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final bool obscureText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final void Function(String)? onSubmitted;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  ///labelText cannot be used when hintText is used
  const CustomTextField({
    super.key,
    this.style,
    this.validator,
    this.hintText,
    this.obscureText = false,
    this.onTap,
    this.onChanged,
    this.controller,
    this.readOnly = false,
    this.textInputAction = TextInputAction.done,
    this.textInputType,
    this.autovalidateMode,
    this.labelText,
    this.labelTextStyle,
    this.prefix,
    this.suffix,
    this.maxLines,
    this.borderColor,
    this.onSubmitted,
    this.inputFormatters,
    this.hintTextStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFFBDBDBD),
      fontWeight: FontWeight.w500,
    ),
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 15,
    ),
    this.initialValue,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hide;
  @override
  void initState() {
    super.initState();
    hide = widget.obscureText;
  }

  getSuffix(){
    if (widget.suffix != null) return widget.suffix;
    return widget.obscureText
        ? IconButton(
      onPressed: () {
        setState(() {
          hide = !hide;
        });
      },
      icon: !hide
          ? Icon(
        Icons.visibility_outlined,
        size: 20,
      )
          : const Icon(Icons.visibility_off_outlined, size: 20),
    ): null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        initialValue: widget.initialValue,
        style: widget.style ?? TextStyle(color: Colors.grey[800]),
        autovalidateMode: widget.autovalidateMode,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        readOnly: widget.readOnly,
        controller: widget.controller,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        obscureText: hide,
        maxLines: widget.maxLines ?? 1,
        validator: widget.validator,
        onFieldSubmitted: widget.onSubmitted,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          prefixIcon: widget.prefix,
          isDense: false,
          contentPadding: widget.contentPadding,
          suffixIcon: getSuffix(),
          filled: true,
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: widget.hintTextStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: widget.labelTextStyle ?? TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
