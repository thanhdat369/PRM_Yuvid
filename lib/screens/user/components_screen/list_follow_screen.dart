import 'package:flutter/material.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/user/components/list_user_component.dart';
import 'package:prm_yuvid/screens/user/components_screen/user_screen_back_button.dart';

class ListFollowScreen extends StatelessWidget {
  List<AccountDTO> list;
  String title;
  ListFollowScreen({Key key, this.title = "Follower", this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserScreenBackButton(
      title: this.title,
      child: Container(
        width: size.width,
        height: size.height,
        child: ListAccountComponent(list_user: this.list),
      ),
    );
  }
}
