import 'package:flutter/material.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/screens/user/components_screen/other_user_profile.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/user_home.dart';

class MyCircleAvatar extends StatelessWidget {
  final int userID;
  final double radius;
  final String imgPath;
  const MyCircleAvatar(
      {Key key,
      this.radius = 40,
      this.imgPath =
          "https://www.daunhotsinopec.com/public/front-end/images/avatar.jpg",
      this.userID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.userID != null) {
          if (this.userID == MockSession.id) {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return UserHomeScreen(id: MockSession.id, tabs_id: 3);
            }));
          } else {
            // TODO Chuyen ve trang
            print("USER ID ");
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return OtherUserProfileParentScreen(accountID: this.userID);
            }));
          }
        }
      },
      child: CircleAvatar(
        radius: this.radius,
        child: ClipOval(
          child: Image.network(
            this.imgPath ??
                "https://www.daunhotsinopec.com/public/front-end/images/avatar.jpg",
            width: this.radius * 2,
            height: this.radius * 2,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
