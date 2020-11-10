import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/models/commentDTO.dart';
import 'package:prm_yuvid/repositories/comment_repo.dart';

part 'post_comment_event.dart';
part 'post_comment_state.dart';

class PostCommentBloc extends Bloc<PostCommentEvent, PostCommentState> {
  CommentRepo commmentRepo;
  
  PostCommentBloc() : super(PostCommentInitial()){
    this.commmentRepo = CommentRepo();
  }

  @override
  // TODO: implement initialState
  PostCommentState get initialState => PostCommentInitial();

  @override
  Stream<PostCommentState> mapEventToState(
    PostCommentEvent event,
  ) async* {
    try {
      if (event is PostCommentButtonPressEvent) {
        yield PostCommentLoadingState();
        var user = await commmentRepo.postCommentInVideo(event.dto);
        print("??????");
        yield PostCommentSuccessState(videoId: event.dto.videoId);
      }
    } catch (e) {
      yield PostCommentFailedState(message: e.toString().substring(10));
    }
    // TODO: implement mapEventToState
  }
}
