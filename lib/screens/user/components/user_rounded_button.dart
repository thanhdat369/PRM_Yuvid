import 'package:flutter/material.dart';
import 'package:prm_yuvid/themes/colors.dart';

class UserRoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const UserRoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = MainColors.kMain,
    this.textColor = MainColors.kLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: this.color,
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        width: size.width * 0.4,
        height: size.height * 0.07,
        child: Center(
          child: Text(
            text.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontFamily: "Product Sans"),
          ),
        ),
      ),
    );
  }
}
