import 'package:chewie/chewie.dart';
import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/screens/shared/my_circleavt.dart';
import 'package:prm_yuvid/screens/user/components_screen/comment/comment_screen.dart';
import 'package:prm_yuvid/themes/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatefulWidget {
  final VideoDTO videoDTO;
  VideoCard({this.videoDTO});
  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController _videoController;
  ChewieController _chewieController;
  bool isLiked;
  bool isPlaying;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(widget.videoDTO.src)
    //   ..initialize().then((_) {
    //     setState(() {
    //       _controller.play();
    //     });
    //   });
    // _videoController = VideoPlayerController.network(widget.videoDTO.src);
    _videoController = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      aspectRatio: _videoController.value.aspectRatio,
      autoPlay: true,
      looping: true,

      // Try playing around with some of these other options:

      showControls: false,

      autoInitialize: true,
    );

    isLiked = true;
    isPlaying = true;
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
            Text(widget.videoDTO.name == null ? "" : widget.videoDTO.name,
                style: TextStyle(color: MainColors.kSoftLight, fontSize: 20)),
            Text(
              widget.videoDTO.createdAt == null
                  ? ""
                  : widget.videoDTO.createdAt,
              style: TextStyle(color: MainColors.kSoftLight),
            ),
            Text(
              widget.videoDTO.description == null
                  ? ""
                  : widget.videoDTO.description,
              style: TextStyle(color: MainColors.kSoftLight),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          print("hello");
          setState(() {
            if (isPlaying) {
              _chewieController.pause();
            } else {
              _chewieController.play();
            }
            isPlaying = !isPlaying;
          });
        },
        child: Center(
            child: Chewie(
          controller: _chewieController,
        )),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(
                isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                color: Colors.blueAccent,
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
              child: Icon(
                Icons.comment,
                color: Colors.blue,
                size: 33.0,
              ),
              onPressed: () {
                print("hello");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommentParent(
                            videoId: this.widget.videoDTO.id,
                          )),
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
    _videoController.dispose();
    _chewieController.dispose();
  }
}
