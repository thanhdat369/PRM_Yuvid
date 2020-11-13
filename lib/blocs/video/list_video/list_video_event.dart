part of 'list_video_bloc.dart';

abstract class ListVideoEvent extends Equatable {
  const ListVideoEvent();
  @override
  List<Object> get props => [];
}

class FetchListVideoEvent extends ListVideoEvent {
  static final int LIKED_VIDEO_MODE = 1;
  static final int USER_VIDEO_MODE = 0;
  int userID;
  int mode;
  FetchListVideoEvent({@required this.mode, this.userID});
}
