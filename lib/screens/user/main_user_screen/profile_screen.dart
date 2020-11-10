import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prm_yuvid/App.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/screens/user/components_screen/edit_profile_screen.dart';
import 'package:prm_yuvid/themes/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  Widget buildInfomation(String name, {String path = null}) {
    if (path == null) {
      path =
          "https://i.pinimg.com/originals/dd/0c/7a/dd0c7aeed07d06e4b4e1a6e4544d57f2.jpg";
    }
    return Column(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: path,
            height: 130.0,
            width: 130.0,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buildFollowInfo({int follower = 0, int following = 0}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                following.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Following",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                follower.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Followers",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: MainColors.kDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: buildInfomation("Dat Le"),
            ),
            buildFollowInfo(follower: 10, following: 30),
            Center(
              child: Row(
                children: [
                  Container(
                      width: 140,
                      height: 40,
                      margin: EdgeInsets.only(bottom: 10, left: 30),
                      decoration:
                          BoxDecoration(border: Border.all(color: MainColors.kLight)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileParentScreen()),
                          );
                        },
                        child: Center(
                          child: Text(
                            "Edit profile",
                            style:
                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ),

                    Container(
                      width: 140,
                      height: 40,
                      margin: EdgeInsets.only(bottom: 10, left: 20),
                      decoration:
                          BoxDecoration(border: Border.all(color: MainColors.kLight)),
                      child: InkWell(
                        onTap: () {
                          MockSession.logout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => App()),
                          );
                        },
                        child: Center(
                          child: Text(
                            "Log out",
                            style:
                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        border: Border.all(color: Colors.white70, width: .5)),
                    child: FittedBox(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                            "https://media.giphy.com/media/Ii4Cv63yG9iYawDtKC/giphy.gif",
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        border: Border.all(color: Colors.white70, width: .5)),
                    child: FittedBox(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                            "https://media.giphy.com/media/tqfS3mgQU28ko/giphy.gif",
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        border: Border.all(color: Colors.white70, width: .5)),
                    child: FittedBox(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                            "https://media.giphy.com/media/3o72EX5QZ9N9d51dqo/giphy.gif",
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
