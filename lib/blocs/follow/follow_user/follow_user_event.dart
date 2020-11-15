part of 'follow_user_bloc.dart';

abstract class FollowUserEvent extends Equatable {
  const FollowUserEvent();

  @override
  List<Object> get props => [];
}

class FetchFollowUserEvent extends FollowUserEvent {
  int userSrcId;
  int userDesId;
  FetchFollowUserEvent({this.userDesId, this.userSrcId});
}

class ClickFollowUserEvent extends FollowUserEvent {
  static final int UNFOLLOW_MODE = 0;
  static final int FOLLOW_MODE = 1;
  int userSrcId;
  int userDesId;
  int mode;
  ClickFollowUserEvent({this.userDesId, this.userSrcId, this.mode});
}
