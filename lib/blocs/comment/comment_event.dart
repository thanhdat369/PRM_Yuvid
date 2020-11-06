part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class FetchCommentEvent extends CommentEvent{
  int idVideo;
  FetchCommentEvent({this.idVideo});
}
