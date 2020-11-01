import 'package:flutter/material.dart';
import 'package:prm_yuvid/themes/colors.dart';

class SquareImage extends StatelessWidget {
  double size;
  double radi;
  double boWi;
  SquareImage({Key key, this.size = 100, this.radi = 20, this.boWi = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/images/background/mans.jpg'),
              fit: BoxFit.fill,
            ),
            border: Border.all(width: boWi, color: MainColors.kLight),
            borderRadius: BorderRadius.circular(radi)),
      ),
    );
  }
}
