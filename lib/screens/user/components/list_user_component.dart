import 'package:flutter/material.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/shared/my_circleavt.dart';
import 'package:prm_yuvid/themes/colors.dart';

class ListAccountComponent extends StatelessWidget {
  List<AccountDTO> list_user;
  ListAccountComponent({Key key, this.list_user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Divider(),
      Expanded(
        child: ListView.builder(
          itemCount: this.list_user.length,
          itemBuilder: (BuildContext context, int index) {
            return AccountItem(dto: list_user[index]);
          },
        ),
      )
    ]);
  }
}

class AccountItem extends StatelessWidget {
  AccountDTO dto;
  AccountItem({Key key, @required this.dto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: MyCircleAvatar(
                    radius: size.width * 0.075,
                    imgPath: dto.avatarSrc,
                    userID: dto.id,
                  )),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Username: " + dto.username == null
                            ? "No username"
                            : dto.username,
                        style: TextStyle(
                            color: MainColors.kLight,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ), //title
                    Container(
                        width: size.width * 0.8 - 100,
                        child: Text(
                            "Name: " + dto.name == null ? "No Name" : dto.name,
                            maxLines: 3,
                            style: TextStyle(
                                letterSpacing: 1.0,
                                fontFamily: "Product Sans",
                                fontSize: 14),
                            overflow: TextOverflow.clip)), //description
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: MainColors.kLight,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
