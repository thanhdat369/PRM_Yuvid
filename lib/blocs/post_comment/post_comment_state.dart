part of 'post_comment_bloc.dart';

abstract class PostCommentState extends Equatable {
  const PostCommentState();
  
  @override
  List<Object> get props => [];
}

class PostCommentInitial extends PostCommentState {}

class PostCommentLoadingState extends PostCommentState {}

class PostCommentFailedState extends PostCommentState {
  final String message;
  PostCommentFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}

class PostCommentSuccessState extends PostCommentState {
   final int videoId;
  
   PostCommentSuccessState({@required this.videoId});

  @override
  List<Object> get props => [];
}