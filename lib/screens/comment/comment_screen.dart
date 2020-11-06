import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm_yuvid/blocs/comment/comment_bloc.dart';

class CommnetParent extends StatelessWidget {
  int videoId;
  CommnetParent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentBloc(),
      child: CommentChildScreen(
        videoId: this.videoId,
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
    _commentBloc = BlocProvider.of(context);
    _commentBloc.add(FetchCommentEvent(idVideo:this.widget.videoId));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('text'),
    );
  }
}
