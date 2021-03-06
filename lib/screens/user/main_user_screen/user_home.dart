import 'package:flutter/material.dart';
import 'package:prm_yuvid/blocs/account/search_account/search_account_bloc.dart';
import 'package:prm_yuvid/screens/user/components_screen/upload_test_screen.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/profile_screen.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/search_user_screen.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/video_screen.dart';
import 'package:prm_yuvid/themes/colors.dart';

class UserScreenItem {
  String title;
  Widget screen;
  UserScreenItem(this.title, this.screen);
}

class UserHomeScreen extends StatefulWidget {
  int id;
  int tabs_id;
  UserHomeScreen({Key key, this.id, this.tabs_id = 1}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  var _currentindex;
  var _tabs = [
    UserScreenItem("HOME", VideoScreenParent()),
    UserScreenItem("UPLOAD", UploadScreenParent()),
    UserScreenItem("SEARCH USER", SearchAccountScreenParent()),
    UserScreenItem("PROFILE", ProfileScreen()),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentindex = this.widget.tabs_id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MainColors.kDark,
        title: Text(_tabs[_currentindex].title,
            style: TextStyle(
                color: MainColors.kSoftLight,
                fontFamily: "Noto Sans",
                fontWeight: FontWeight.w700,
                fontSize: 19)),
        centerTitle: true,
      ),
      backgroundColor: MainColors.kDark,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: _tabs[_currentindex].screen,
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: MainColors.kMain, width: 3))),
          padding: EdgeInsets.only(top: 10),
          child: BottomNavigationBar(
            currentIndex: _currentindex,
            onTap: (index) {
              setState(() {
                _currentindex = index;
              });
            },
            unselectedItemColor: MainColors.kLight,
            type: BottomNavigationBarType.fixed,
            backgroundColor: MainColors.kDark,
            items: [
              BottomNavigationBarItem(
                label: "VIDEO",
                icon: Icon(Icons.play_arrow),
              ),
              BottomNavigationBarItem(label: "UPLOAD", icon: Icon(Icons.add)),
              BottomNavigationBarItem(
                  label: "SEARCH", icon: Icon(Icons.search)),
              BottomNavigationBarItem(
                  label: "PROFILE", icon: Icon(Icons.account_box)),
            ],
          )),
    );
  }
}
