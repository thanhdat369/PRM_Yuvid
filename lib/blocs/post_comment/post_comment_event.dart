part of 'post_comment_bloc.dart';

abstract class PostCommentEvent extends Equatable {
  const PostCommentEvent();

  @override
  List<Object> get props => [];
}

class PostCommentInitEvent extends PostCommentEvent {
  @override
  List<Object> get props => [];
}

class PostCommentButtonPressEvent extends PostCommentEvent {
  
  CommentPostDTO dto = CommentPostDTO();

  PostCommentButtonPressEvent({@required this.dto});
  
  @override
  List<Object> get props => [];
}
