part of 'like_bloc.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class LikeVideoClickEvent extends LikeEvent {
  int videoID;
  int userID;
  bool isClickLike;
  LikeVideoClickEvent({this.videoID, this.userID, this.isClickLike});
}
