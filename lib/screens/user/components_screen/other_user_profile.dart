import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/account/profile/profile_bloc.dart';
import 'package:prm_yuvid/blocs/follow/follow_counter/follow_counter_bloc.dart';
import 'package:prm_yuvid/blocs/follow/follow_user/follow_user_bloc.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/user/components_screen/other_user_video.dart';
import 'package:prm_yuvid/screens/user/components_screen/user_screen_back_button.dart';
import 'package:prm_yuvid/themes/colors.dart';

class OtherUserProfileParentScreen extends StatelessWidget {
  final int accountID;
  const OtherUserProfileParentScreen({Key key, this.accountID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => FollowCounterBloc(),
        ),
        BlocProvider(
          create: (context) => FollowUserBloc(),
        )
      ],
      child: OtherUserProfileScreen(accountID: this.accountID),
    );
  }
}

class OtherUserProfileScreen extends StatefulWidget {
  final int accountID;
  OtherUserProfileScreen({Key key, this.accountID}) : super(key: key);

  @override
  _OtherUserProfileScreenState createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  ProfileBloc profileBloc;
  FollowCounterBloc followCounterBloc;
  FollowUserBloc followUserBloc;
  AccountDTO accountDTO;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchProfileEvent(accountId: this.widget.accountID));
    followCounterBloc = BlocProvider.of<FollowCounterBloc>(context);
    followCounterBloc
        .add(FetchFollowCountertEvent(userID: this.widget.accountID));
    followUserBloc = BlocProvider.of<FollowUserBloc>(context);
    followUserBloc.add(FetchFollowUserEvent(
        userSrcId: MockSession.id, userDesId: this.widget.accountID));
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
        ClipOval(
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: accountDTO.avatarSrc,
            height: 130.0,
            width: 130.0,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserScreenBackButton(
        title: "OTHER PROFILE",
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: buildInfomation(accountDTO: this.accountDTO),
                      ),
                      BlocBuilder<FollowUserBloc, FollowUserState>(
                          builder: (context, state) {
                        if (state is FollowUserLoadingState) {
                          return CircularProgressIndicator();
                        } else if (state is FollowUserNotFollowingState) {
                          return buttonNavigateComponent(
                              text: "Follow",
                              press: () => _clickFollowing(true));
                        } else if (state is FollowUserFollowingState) {
                          return buttonNavigateComponent(
                              text: "Following",
                              press: () => _clickFollowing(false));
                        } else if (state is FollowUserFailedState) {
                          return Text(
                            state.message,
                            style: TextStyle(color: Colors.red),
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
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20)));
                        } else if (state is FollowCounterSuccessState) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: buildFollowInfo(
                                follower: state.followerList,
                                following: state.followingList),
                          );
                        } else {
                          return Container();
                        }
                      }),
                      buildButtonNavigation(context,
                          name: this.accountDTO.name),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
            ])));
  }

  Widget buildFollowInfo(
      {List<AccountDTO> follower, List<AccountDTO> following}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
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
        Padding(
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
      ],
    );
  }

  Widget buildButtonNavigation(BuildContext context,
      {String name = "No name"}) {
    if (name == null) {
      name = "No name";
    }
    return Center(
      child: Column(
        children: [
          buttonNavigateComponent(
              text: "${name}'s Video",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtherUserVideoParentScreen(
                            accountDTO: this.accountDTO,
                          )),
                );
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

  _clickFollowing(bool modeFollow) {
    int mode;
    if (modeFollow) {
      mode = ClickFollowUserEvent.FOLLOW_MODE;
    } else {
      mode = ClickFollowUserEvent.UNFOLLOW_MODE;
    }

    this.followUserBloc.add(ClickFollowUserEvent(
        userSrcId: MockSession.id,
        userDesId: this.widget.accountID,
        mode: mode));
  }
}
