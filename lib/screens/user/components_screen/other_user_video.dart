import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/video/list_video/list_video_bloc.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/screens/user/components_screen/list_video_screen.dart';
import 'package:prm_yuvid/screens/user/components_screen/user_screen_back_button.dart';

class OtherUserVideoParentScreen extends StatelessWidget {
  final AccountDTO accountDTO;
  const OtherUserVideoParentScreen({Key key, this.accountDTO})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListVideoBloc(),
      child: OtherUserVideoScreen(accountDTO: this.accountDTO),
    );
  }
}

class OtherUserVideoScreen extends StatefulWidget {
  AccountDTO accountDTO;
  OtherUserVideoScreen({Key key, this.accountDTO}) : super(key: key);

  @override
  _OtherUserVideoScreenState createState() => _OtherUserVideoScreenState();
}

class _OtherUserVideoScreenState extends State<OtherUserVideoScreen> {
  ListVideoBloc _listVideoBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listVideoBloc = BlocProvider.of<ListVideoBloc>(context);
    _listVideoBloc.add(FetchListVideoEvent(
        mode: FetchListVideoEvent.USER_VIDEO_MODE,
        userID: this.widget.accountDTO.id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return UserScreenBackButton(
        title: "Video of ${widget.accountDTO.name}",
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
