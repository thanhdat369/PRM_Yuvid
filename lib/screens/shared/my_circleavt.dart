import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  final double radius;
  final String imgPath;
  const MyCircleAvatar(
      {Key key,
      this.radius = 40,
      this.imgPath = "asset/images/user_screen/noavt.jpg"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: this.radius,
      child: ClipOval(
        child: Image.asset(
          this.imgPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
