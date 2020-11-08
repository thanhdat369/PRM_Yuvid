part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
  
  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentFailedState extends CommentState {
  final String message;
  CommentFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}

class CommentSuccessState extends CommentState {
  //final int commentId;
  List<CommentReadDTO> list = List();

  // final String username;
  // LoginSuccessState({@required this.id, @required this.username});
  CommentSuccessState({@required this.list});

  @override
  List<Object> get props => [];
}
