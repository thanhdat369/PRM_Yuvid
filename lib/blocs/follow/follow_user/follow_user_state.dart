part of 'follow_user_bloc.dart';

abstract class FollowUserState extends Equatable {
  const FollowUserState();

  @override
  List<Object> get props => [];
}

class FollowUserInitial extends FollowUserState {}

class FollowUserLoadingState extends FollowUserState {}

class FollowUserFailedState extends FollowUserState {
  final String message;
  FollowUserFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}

class FollowUserFollowingState extends FollowUserState {
  @override
  List<Object> get props => [];
}

class FollowUserNotFollowingState extends FollowUserState {
  @override
  List<Object> get props => [];
}
