import 'package:flutter/material.dart';
import 'package:prm_yuvid/themes/colors.dart';
class ContainerRounded extends StatelessWidget {
  Widget child;
  ContainerRounded({Key key,@required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: MainColors.kSoftDark),
        child: this.child,
      );
  }
}