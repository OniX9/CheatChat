import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckbox extends StatefulWidget {
  void Function(bool) onChanged;

  CustomCheckbox({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChanged(isChecked);
        });
      },
      child: Container(
        margin: EdgeInsets.all(15),
        width: 18.2,
        height: 18.2,
        decoration: BoxDecoration(
          // color: isChecked ? widget.activeColor : widget.inactiveColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: isChecked
            ? SvgPicture.asset(// change to a thicker tick icon svg/ png.
            'images/onboard_screen/checkbox_checked.svg')
            : SvgPicture.asset(// change to a thicker tick icon svg/ png.
            'images/onboard_screen/checkbox_unchecked.svg'),
      ),
    );
  }
}
