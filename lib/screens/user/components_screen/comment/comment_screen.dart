
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/comment/comment_bloc.dart';
import 'package:prm_yuvid/screens/user/components_screen/comment/comment_component/comment_component.dart';
import 'package:prm_yuvid/themes/colors.dart';

class CommentParent extends StatelessWidget {
  int videoId;
  CommentParent({Key key,this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentBloc(),
      child: Scaffold(
        body: CommentChildScreen(
          videoId: this.videoId,
        ),
      ),
    );
  }
}

class CommentChildScreen extends StatefulWidget {
  int videoId;
  CommentChildScreen({Key key, @required this.videoId}) : super(key: key);

  @override
  _CommentChildScreenState createState() => _CommentChildScreenState();
}

class _CommentChildScreenState extends State<CommentChildScreen> {
  CommentBloc _commentBloc;
  @override
  void initState() {
    super.initState();
    _commentBloc = BlocProvider.of<CommentBloc>(context);
    _commentBloc.add(FetchCommentEvent(idVideo: this.widget.videoId));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height:size.height ,
      color: MainColors.kDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<CommentBloc, CommentState>(
            listener: (context, state) {},
            child: BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
              if (state is CommentInitial) {
                return SizedBox.shrink();
              } else if (state is CommentLoadingState) {
                return buildLoading();
              } else if (state is CommentSuccessState) {
                print("hello");
                return CommentListComponent(list: state.list,videoID:this.widget.videoId);
                // return Container();
              } else if (state is CommentFailedState) {
                return buildFailure(state.message);
              } else {
                return SizedBox.shrink();
              }
            }),
          ),
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
}
