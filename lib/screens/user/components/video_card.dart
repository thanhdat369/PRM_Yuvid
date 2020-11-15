import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/video/like/like_bloc.dart';
import 'package:prm_yuvid/mock/date_time_process.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/screens/shared/my_circleavt.dart';
import 'package:prm_yuvid/screens/user/components_screen/comment/comment_screen.dart';
import 'package:prm_yuvid/themes/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final isAutoplay;
  final VideoDTO videoDTO;
  const VideoCard({Key key, this.videoDTO, this.isAutoplay = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => LikeBloc(),
        child: VideoCardChild(videoDTO: videoDTO, isAutoplay: isAutoplay),
      ),
    );
  }
}

class VideoCardChild extends StatefulWidget {
  final isAutoplay;
  final VideoDTO videoDTO;
  VideoCardChild({this.videoDTO, this.isAutoplay = true});
  @override
  _VideoCardChildState createState() => _VideoCardChildState();
}

class _VideoCardChildState extends State<VideoCardChild> {
  VideoPlayerController _videoController;
  ChewieController _chewieController;
  bool _isLiked;
  bool isPlaying;
  LikeBloc likeBloc;

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
      // aspectRatio: _videoController.value.aspectRatio,
      aspectRatio: 16 / 9,
      autoPlay: this.widget.isAutoplay,
      looping: true,

      // Try playing around with some of these other options:

      showControls: false,

      autoInitialize: true,
    );

    _isLiked = this.widget.videoDTO.likedAccount.contains(MockSession.id);
    isPlaying = this.widget.isAutoplay;
  }

  @override
  Widget build(BuildContext context) {
    likeBloc = BlocProvider.of<LikeBloc>(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                MyCircleAvatar(
                  imgPath: this.widget.videoDTO.avatarSrc,
                  userID: this.widget.videoDTO.authorId,
                  radius: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.videoDTO.authorName == null
                            ? ""
                            : widget.videoDTO.authorName,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        widget.videoDTO.createdAt == null
                            ? ""
                            : getDateTime(widget.videoDTO.createdAt),
                        style: TextStyle(color: MainColors.kSoftLight),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10),
              child: Text(
                  widget.videoDTO.name == null ? "" : widget.videoDTO.name,
                  style: TextStyle(color: MainColors.kSoftLight, fontSize: 20)),
            ),
            Text(
              widget.videoDTO.description == null
                  ? ""
                  : widget.videoDTO.description,
              style: TextStyle(color: MainColors.kSoftLight, fontSize: 18),
              maxLines: 3,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            if (isPlaying) {
              _chewieController.pause();
            } else {
              _chewieController.play();
            }
            isPlaying = !isPlaying;
          });
        },
        child: Container(
            height: size.height * 0.4,
            child: Chewie(
              controller: _chewieController,
            )),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              child: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                color: MainColors.kReact,
                size: 45.0,
              ),
              onPressed: () {
                setState(() {
                  _isLiked = !_isLiked;
                });
                this.likeBloc.add(LikeVideoClickEvent(
                      userID: MockSession.id,
                      videoID: this.widget.videoDTO.id,
                      isClickLike: _isLiked,
                    ));
              },
              backgroundColor: MainColors.kSoftDark,
            ),
            FloatingActionButton(
              heroTag: null,
              child: Icon(
                Icons.comment,
                color: MainColors.kReact,
                size: 33.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommentParent(
                            videoId: this.widget.videoDTO.id,
                          )),
                );
              },
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
