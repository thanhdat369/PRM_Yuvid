import 'package:flutter/material.dart';
import 'package:prm_yuvid/themes/colors.dart';

class UserRoundedInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  TextEditingController textEditingController;
  double width;
  int line;
  UserRoundedInput(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.textEditingController,
      this.line = 1,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (this.width == null) {
      this.width = size.width * 0.85;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: width,
      height: size.height * 0.07 * this.line,
      decoration: BoxDecoration(
        color: MainColors.kSoftLight.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: TextField(
        maxLines: line,
        style: TextStyle(color: MainColors.kLight),
        onChanged: onChanged,
        controller: textEditingController,
        cursorColor: MainColors.kMain,
        decoration: InputDecoration(
          fillColor: MainColors.kLight,
          icon: icon == null
              ? null
              : Icon(
                  icon,
                  color: MainColors.kMain,
                ),
          hintText: hintText,
          hintStyle: TextStyle(color: MainColors.kLight),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
