import 'package:flutter/material.dart';
import 'package:prm_yuvid/screens/user/components_screen/upload_test_screen.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/profile_screen.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/video_screen.dart';

class UserHome extends StatelessWidget {
  int id;
  UserHome({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UploadScreen(),
      // body: VideoScreenParent(),
    );
  }
}
