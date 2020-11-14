import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/models/commentDTO.dart';
import 'package:prm_yuvid/repositories/comment_repo.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentRepo commentRepo;
  List<CommentReadDTO> list = List();

  CommentBloc() : super(CommentInitial()) {
    this.commentRepo = CommentRepo();
  }

  @override
  // TODO: implement initialState
  CommentState get initialState => CommentInitial();

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    // TODO: implement mapEventToState
    try {
      if (event is FetchCommentEvent) {
        yield CommentLoadingState();
        list = await commentRepo.getCommentInVideo(event.idVideo);
        print("--------------");
        yield CommentSuccessState(list: list);
      }
    } catch (e) {
      print(e);
      yield CommentFailedState(message: e.toString().substring(10));
    }
  }
}
