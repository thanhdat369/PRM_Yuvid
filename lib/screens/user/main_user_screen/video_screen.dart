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
  int swipe;
  int page;
  @override
  void initState() {
    videoBloc = BlocProvider.of<VideoBloc>(context);
    videoBloc.add(VideoFetchEvent());
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        alignment: Alignment.center,
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
                  page = state.page;
                  return VideoCard(videoDTO: state.videoDTO);
                }
                return Center(child: Text("Nothing to show"));
              },
            ),
          ),
        ]),
      ),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    // print(details.delta.dx);
    double sensitivity = 0.5;
    if (details.delta.dx > sensitivity) {
      swipe = 1;
      // print('Right');
      // Right Swipe
    } else if (details.delta.dx < -sensitivity) {
      // print('Left');
      swipe = 0;
      //Left Swipe
    } else {
      swipe = null;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (swipe != null) {
      if (swipe == 0) {
        videoBloc.add(VideoPagePressEvent(page: this.page + 1));
      } else if (swipe == 1) {
        videoBloc.add(VideoPagePressEvent(page: this.page - 1));
      }
    }
    print("---------------\n page $page");
  }
}
