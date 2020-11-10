import 'package:flutter/material.dart';
import 'package:prm_yuvid/themes/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  TextEditingController textEditingController;
  RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.85,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: MainColors.kSoftLight.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        
      ),
      child: TextField(
        style: TextStyle(color: MainColors.kLight),
        onChanged: onChanged,
        controller: textEditingController,
        cursorColor: MainColors.kMain,
        decoration: InputDecoration(
          fillColor: MainColors.kLight,
          icon: Icon(
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
