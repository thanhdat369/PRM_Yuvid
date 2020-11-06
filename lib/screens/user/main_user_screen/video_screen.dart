import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/video/load/video_bloc.dart';
import 'package:prm_yuvid/screens/user/components/video_card.dart';
import 'package:prm_yuvid/themes/colors.dart';

class VideoScreenParent extends StatelessWidget {
  const VideoScreenParent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoBloc>(
      create: (context) => VideoBloc(),
      child: VideoScreen(),
    );
  }
}

class VideoScreen extends StatefulWidget {
  VideoScreen({Key key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoBloc videoBloc;
  @override
  @override
  void initState() {
    videoBloc = BlocProvider.of<VideoBloc>(context);
    videoBloc.add(VideoFetchEvent());
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: MainColors.kDark,
      child: Column(children: [
        BlocListener<VideoBloc, VideoState>(
          listener: (context, state) {},
          child: BlocBuilder<VideoBloc, VideoState>(
            builder: (context, state) {
              if (state is VideoInitial) {
                return CircularProgressIndicator();
              }
              if (state is VideoFailedState) {
                return Text(state.error);
              }
              if (state is VideoSuccessState) {
                print(state.videoDTO.src);
                return Column(
                  children: [
                    VideoCard(videoDTO: state.videoDTO),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FloatingActionButton(
                              onPressed: () {
                                videoBloc.add(
                                    VideoPagePressEvent(page: state.page - 1));
                              },
                              child: Icon(Icons.navigate_before)),
                          FloatingActionButton(
                              onPressed: () {
                                videoBloc.add(
                                    VideoPagePressEvent(page: state.page + 1));
                              },
                              child: Icon(Icons.navigate_next)),
                        ]),
                  ],
                );
              }
              return Center(child: Text("Nothing to show"));
            },
          ),
        ),
      ]),
    ));
  }
}
