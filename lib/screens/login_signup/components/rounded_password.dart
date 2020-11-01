import 'package:flutter/material.dart';
import 'package:prm_yuvid/themes/colors.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool ishaveVisibleButton;
  TextEditingController textEditingController;
  RoundedPasswordField(
      {Key key,
      this.hintText,
      this.icon = Icons.lock,
      this.onChanged,
      this.ishaveVisibleButton = true,
      this.textEditingController})
      : super(key: key);
  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool hidden_password = true;
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
        obscureText: hidden_password,
        onChanged: widget.onChanged,
        autofocus: false,
        controller: widget.textEditingController,
        cursorColor: MainColors.kMain,
        style: TextStyle(color: MainColors.kLight),
        decoration: InputDecoration(
          fillColor: MainColors.kLight,
          icon: Icon(
            widget.icon,
            color: MainColors.kMain,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: MainColors.kLight),
          border: InputBorder.none,
          suffixIcon: widget.ishaveVisibleButton
              ? IconButton(
                  icon: Icon(Icons.visibility, color: MainColors.kMain),
                  onPressed: () {
                    setState(() {
                      hidden_password = !hidden_password;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
