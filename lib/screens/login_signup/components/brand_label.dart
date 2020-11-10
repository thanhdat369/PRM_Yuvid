import 'package:flutter/material.dart';

class BrandLabel extends StatelessWidget {
  const BrandLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 75,
              child: Text("YuVid",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Product Sans",
                      letterSpacing: 10,
                      fontSize: 70),
                  textAlign: TextAlign.center),
            ),
            Container(
              height: 24,
              child: Text("Share and play video ",
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Product Sans",
                      letterSpacing: 0,
                      fontSize: 17),
                  textAlign: TextAlign.center),
            )
          ],
        ));
  }
}
