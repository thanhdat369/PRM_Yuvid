part of 'video_bloc.dart';

@immutable
abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class VideoPagePressEvent extends VideoEvent {
  int page;
  VideoPagePressEvent({@required this.page});
  @override
  List<Object> get props => [page];
}

class VideoFetchEvent extends VideoEvent {}
