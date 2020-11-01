import 'package:flutter/material.dart';
import 'package:prm_yuvid/themes/colors.dart';

import 'components/brand_label.dart';
import 'components/screen_with_background.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MainColors.kSoftDark,
        body: ScreenWithBackground(
          pathBackground: "asset/images/background/background.jpg",
          child: BrandLabel(),
        ));
  }
}
