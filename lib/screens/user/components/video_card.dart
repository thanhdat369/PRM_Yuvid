import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/screens/shared/my_circleavt.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatefulWidget {
  final VideoDTO videoDTO;
  VideoCard({this.videoDTO});
  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController _controller;

  bool isLiked;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoDTO.src)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    isLiked = true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                MyCircleAvatar(
                  radius: 20,
                ),
                Text(widget.videoDTO.authorName == null
                    ? ""
                    : widget.videoDTO.authorName),
              ],
            ),
            Text(widget.videoDTO.description == null
                ? ""
                : widget.videoDTO.description),
          ],
        ),
      ),
      Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: Colors.pink,
                size: 33.0,
              ),
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
                //   BlocProvider.of<UploadBloc>(context).add(LikedButtonPressed(
                //       uid: widget.user, videoReference: widget.videoReference));
              },
              heroTag: "favourite",
              backgroundColor: Colors.white,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              heroTag: "VideoControl",
            ),
            FloatingActionButton(
              child: Icon(
                Icons.comment,
                color: Colors.blue,
                size: 33.0,
              ),
              onPressed: () async {
                await FlutterShare.share(
                  title: 'Watch this Awesome Video !',
                  linkUrl: widget.videoDTO.src,
                );
              },
              heroTag: "share",
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    ]));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
