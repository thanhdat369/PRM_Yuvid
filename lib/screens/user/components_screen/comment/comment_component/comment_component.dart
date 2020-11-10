import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/post_comment/post_comment_bloc.dart';
import 'package:prm_yuvid/mock/date_time_process.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/models/commentDTO.dart';
import 'package:prm_yuvid/screens/shared/my_circleavt.dart';
import 'package:prm_yuvid/screens/user/components_screen/comment/comment_screen.dart';
import 'package:prm_yuvid/themes/colors.dart';

// class CommentListComponent extends StatefulWidget {
//   List<CommentReadDTO> list;

//   CommentListComponent({Key key, this.list}) : super(key: key);

//   @override
//   _CommentListComponenttate createState() => _CommentListComponenttate();
// }

class CommentListComponent extends StatelessWidget {
  List<CommentReadDTO> list;
  int videoID;
  CommentListComponent({Key key, this.list,@required this.videoID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCommentBloc(),
      child: CommentChildComponent(list: list,videoID: videoID),
    );
  }
}

class CommentChildComponent extends StatefulWidget {
  int videoID;
  List<CommentReadDTO> list;
  CommentChildComponent({Key key, this.list,@required this.videoID}) : super(key: key);

  @override
  _CommentListComponenttate createState() => _CommentListComponenttate();
}

class _CommentListComponenttate extends State<CommentChildComponent> {
  TextEditingController contentController = new TextEditingController();
  PostCommentBloc _postCommentBloc;
  @override
  void initState() {
    super.initState();
    this.widget.list=this.widget.list.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    _postCommentBloc = BlocProvider.of<PostCommentBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: widget.list.length,
              itemBuilder: (BuildContext context, int index) {
                return CommentItem(
                  dto: this.widget.list[index],
                  size: 100,
                );
              },
            ),
          ),
          Container(
              child: SingleChildScrollView(
                  child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: contentController,
                    style: TextStyle(color: MainColors.kLight),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: MainColors.kMain, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: MainColors.kMain,
                        hintText: "Say something...",
                        hintStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: MainColors.kMain, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                ),
                InkWell(
                    onTap: () => () {},
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        color: MainColors.kMain,
                        iconSize: 40,
                        onPressed: postComment,
                      ),
                    )),
                BlocListener<PostCommentBloc, PostCommentState>(
                  listener: (context, state) {
                    if (state is PostCommentSuccessState) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return CommentParent(videoId: this.widget.videoID);
                      }));
                    }
                  },
                  child: BlocBuilder<PostCommentBloc, PostCommentState>(
                      builder: (context, state) {
                    if (state is PostCommentInitial) {
                      return SizedBox.shrink();
                    } else if (state is PostCommentLoadingState) {
                      return buildLoading();
                    } else if (state is PostCommentSuccessState) {
                      return Container();
                    } else if (state is PostCommentFailedState) {
                      return buildFailure(state.message);
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                ),
              ],
            ),
          ))),
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailure(String mess) {
    return Text(mess, style: TextStyle(color: Colors.red));
  }

  void postComment() {
    int videoID = this.widget.videoID;
    print("VideoID $videoID");
    int authorID = MockSession.id;
    if (contentController.text.isEmpty) {
    } else {
      String _content = contentController.text;

      CommentPostDTO _dto =
          CommentPostDTO(authorId:authorID , videoId: videoID, content: _content);
      _postCommentBloc.add(PostCommentButtonPressEvent(dto: _dto));
    }
  }
}

class CommentItem extends StatelessWidget {
  CommentReadDTO dto;
  double size;
  CommentItem({Key key, this.size = 20, this.dto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(60, 0, 20, 0),
            height: size,
            width: size,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: MainColors.kLight),
              borderRadius: BorderRadius.all(Radius.circular(70)),
            ),
            child: MyCircleAvatar(
              radius: 70,
              imgPath: dto.authorAvatarSrc == null
                  ? "asset/images/user_screen/noavt.jpg"
                  : dto.authorAvatarSrc,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    //this.title.toUpperCase(),
                    this.dto.authorName ?? "",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    this.dto.content ?? "",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  getDateTime(this.dto.createdAt),
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//       child: UserScreenBackButton(
//       title: "VIDEO NAME",
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.only(bottom: 100),
//               children: <Widget>[
//                 ItemExercise(),
//                  ItemExercise(
//                     title: "Name User",
//                     imagePath: "asset/images/background/mans.jpg",
//                     des: "The http package provides the simplest way to fetch data from the internet.",
//                     timePost: "7 giờ",
//                 ),

//                 ],
//             ),
//           )
//         ],
//       ),
//     )
//     );
