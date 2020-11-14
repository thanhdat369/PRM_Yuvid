import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/video/list_video/list_video_bloc.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/user/components_screen/list_video_screen.dart';
import 'package:prm_yuvid/screens/user/components_screen/user_screen_back_button.dart';

class LikedVideoParentScreen extends StatelessWidget {
  const LikedVideoParentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListVideoBloc(),
      child: LikedVideoScreen(),
    );
  }
}

class LikedVideoScreen extends StatefulWidget {
  LikedVideoScreen({Key key}) : super(key: key);

  @override
  _LikedVideoScreenState createState() => _LikedVideoScreenState();
}

class _LikedVideoScreenState extends State<LikedVideoScreen> {
  ListVideoBloc _listVideoBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listVideoBloc = BlocProvider.of<ListVideoBloc>(context);
    _listVideoBloc.add(FetchListVideoEvent(
        mode: FetchListVideoEvent.LIKED_VIDEO_MODE, userID: MockSession.id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserScreenBackButton(
        title: "Liked Videos",
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<ListVideoBloc, ListVideoState>(
                    builder: (context, state) {
                  if (state is ListVideoInitial) {
                    return SizedBox.shrink();
                  } else if (state is ListVideoLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ListVideoSuccessState) {
                    return Container(
                        width: size.width,
                        height: size.height * 0.9,
                        child: ListVideoComponent(list: state.list_video));
                  } else if (state is ListVideoFailedState) {
                    return Text("An error when loading video",
                        style: TextStyle(color: Colors.red));
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ]),
        ));
  }
}
