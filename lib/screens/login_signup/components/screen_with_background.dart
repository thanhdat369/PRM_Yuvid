import 'package:flutter/material.dart';

class ScreenWithBackground extends StatelessWidget {
  final String pathBackground;
  final Widget child;
  final double opacity;

  const ScreenWithBackground(
      {Key key,
      @required this.pathBackground,
      @required this.child,
      this.opacity = 0.2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Opacity(
            opacity: opacity,
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage(
                    pathBackground,
                  ),
                ),
              ),
            )),
        Container(
          child: this.child,
        )
      ],
    );
  }
}
