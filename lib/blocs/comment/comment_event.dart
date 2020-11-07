part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentInitEvent extends CommentEvent {
  @override
  List<Object> get props => [];
}

class FetchCommentEvent extends CommentEvent{
  final int idVideo;
  FetchCommentEvent({@required this.idVideo});

  @override
  List<Object> get props => [];
}
