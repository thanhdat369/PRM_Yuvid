import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/App.dart';
import 'package:prm_yuvid/blocs/account/profile/profile_bloc.dart';
import 'package:prm_yuvid/blocs/follow/follow_counter/follow_counter_bloc.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/user/components_screen/edit_avt_screen.dart';
import 'package:prm_yuvid/screens/user/components_screen/edit_profile_screen.dart';
import 'package:prm_yuvid/screens/user/components_screen/liked_video_list.dart';
import 'package:prm_yuvid/screens/user/components_screen/list_follow_screen.dart';
import 'package:prm_yuvid/screens/user/components_screen/my_following_video.dart';
import 'package:prm_yuvid/screens/user/main_user_screen/my_video.dart';
import 'package:prm_yuvid/themes/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => FollowCounterBloc(),
        )
      ],
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
  FollowCounterBloc followCounterBloc;
  AccountDTO accountDTO;
  @override
  void initState() {
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchProfileEvent(accountId: MockSession.id));
    followCounterBloc = BlocProvider.of<FollowCounterBloc>(context);
    followCounterBloc.add(FetchFollowCountertEvent(userID: MockSession.id));
    accountDTO = AccountDTO();
  }

  Widget buildInfomation({AccountDTO accountDTO}) {
    if (accountDTO == null) {
      return Container();
    }
    if (accountDTO.avatarSrc == null) {
      accountDTO.avatarSrc =
          "https://www.daunhotsinopec.com/public/front-end/images/avatar.jpg";
    }
    if (accountDTO.name == null) {
      accountDTO.name = "No Name";
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
              imageUrl: accountDTO.avatarSrc,
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
            accountDTO.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                accountDTO.email ?? "",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                accountDTO.bio ?? "",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildFollowInfo(
      {List<AccountDTO> follower, List<AccountDTO> following}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListFollowScreen(
                        title: "Following",
                        list: following,
                      )),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  following.length.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Following",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListFollowScreen(
                        title: "Follower",
                        list: follower,
                      )),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  follower.length.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Followers",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProfileFailedState) {
                return Center(
                    child: Text(state.message,
                        style: TextStyle(color: Colors.red, fontSize: 20)));
              } else if (state is ProfileSuccessState) {
                this.accountDTO = state.dto;
                print(accountDTO.name);
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: buildInfomation(accountDTO: this.accountDTO),
                );
              } else {
                return Container();
              }
            }),
            BlocBuilder<FollowCounterBloc, FollowCounterState>(
                builder: (context, state) {
              if (state is FollowCounterLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is FollowCounterFailedState) {
                return Center(
                    child: Text(state.message,
                        style: TextStyle(color: Colors.red, fontSize: 20)));
              } else if (state is FollowCounterSuccessState) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: buildFollowInfo(
                      follower: state.followerList,
                      following: state.followingList),
                );
              } else {
                return Container();
              }
            }),
            buildButtonNavigation(context),
          ],
        ),
      ),
    );
  }

  Widget buildButtonNavigation(BuildContext context) {
    return Center(
      child: Column(
        children: [
          buttonNavigateComponent(
              text: "Edit Profile",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfileParentScreen(
                            accountDTO: this.accountDTO,
                          )),
                );
              }),
          buttonNavigateComponent(
              text: "My Video",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyVideoParentScreen()),
                );
              }),
          buttonNavigateComponent(
              text: "My Liked Video",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LikedVideoParentScreen()),
                );
              }),
          buttonNavigateComponent(
              text: "My Following Video",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyFollowingParentScreen()),
                );
              }),
          buttonNavigateComponent(
              text: "Log out",
              press: () {
                MockSession.logout();
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return App();
                }));
              }),
        ],
      ),
    );
  }

  Widget buttonNavigateComponent({String text, Function press}) {
    return Container(
        width: 140,
        height: 40,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(border: Border.all(color: MainColors.kLight)),
        child: InkWell(
          onTap: press,
          child: Center(
            child: Text(
              "${text}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
