import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/App.dart';
import 'package:prm_yuvid/blocs/account/profile/profile_bloc.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/user/components_screen/edit_avt_screen.dart';
import 'package:prm_yuvid/screens/user/components_screen/edit_profile_screen.dart';
import 'package:prm_yuvid/themes/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: ProfileScreenChild(),
    );
  }
}

class ProfileScreenChild extends StatefulWidget {
  ProfileScreenChild({Key key}) : super(key: key);

  @override
  _ProfileScreenChildState createState() => _ProfileScreenChildState();
}

class _ProfileScreenChildState extends State<ProfileScreenChild> {
  ProfileBloc profileBloc;
  AccountDTO accountDTO;
  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of(context);
    profileBloc.add(FetchProfileEvent(accountId: MockSession.id));
    accountDTO = AccountDTO();
  }

  Widget buildInfomation({String name, String path = null}) {
    if (path == null) {
      path =
          "https://www.daunhotsinopec.com/public/front-end/images/avatar.jpg";
    }
    if (name == null) {
      name = "No Name";
    }
    return Column(
      children: [
        InkWell(
          onDoubleTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditAvtScreen()),
            );
          },
          child: ClipOval(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: path,
              height: 130.0,
              width: 130.0,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileSuccessState) {
          this.accountDTO = state.dto;
          print(accountDTO.name);

          // setState(() {});
        }
        return SafeArea(
          child: Container(
            color: MainColors.kDark,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: buildInfomation(
                      name: accountDTO.name, path: accountDTO.avatarSrc),
                ),
                buildFollowInfo(follower: 10, following: 30),
                Center(
                  child: Row(
                    children: [
                      Container(
                          width: 140,
                          height: 40,
                          margin: EdgeInsets.only(bottom: 10, left: 30),
                          decoration: BoxDecoration(
                              border: Border.all(color: MainColors.kLight)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfileParentScreen()),
                              );
                            },
                            child: Center(
                              child: Text(
                                "Edit profile",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      Container(
                          width: 140,
                          height: 40,
                          margin: EdgeInsets.only(bottom: 10, left: 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: MainColors.kLight)),
                          child: InkWell(
                            onTap: () {
                              MockSession.logout();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => App()),
                              );
                            },
                            child: Center(
                              child: Text(
                                "Log out",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
