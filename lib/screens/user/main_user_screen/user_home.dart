import 'package:flutter/material.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/video_screen.dart';

class UserHome extends StatelessWidget {
  int id;
  UserHome({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: UploadScreenParent(),
      body: SafeArea(
          child: Container(
              // padding: EdgeInsets.all(20),
              alignment: Alignment.bottomCenter,
              child: VideoScreenParent())),
    );
  }
}
