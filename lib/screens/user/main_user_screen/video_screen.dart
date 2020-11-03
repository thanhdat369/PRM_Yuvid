import 'package:flutter/material.dart';
import 'package:prm_yuvid/screens/user/components/video_card.dart';
import 'package:prm_yuvid/themes/colors.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      // height: double.maxFinite,
      // width: double.infinity,
      color: MainColors.kDark,
      child: Column(children: [
        VideoCard(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          FloatingActionButton(
              onPressed: () {}, child: Icon(Icons.navigate_before)),
          FloatingActionButton(
              onPressed: () {}, child: Icon(Icons.navigate_next)),
        ]),
      ]),
    ));
  }
}
