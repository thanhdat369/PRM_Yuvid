part of 'video_bloc.dart';

@immutable
abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoadingState extends VideoState {}

class VideoSuccessState extends VideoState {
  int page;
  VideoDTO videoDTO;
  VideoSuccessState({@required this.videoDTO, @required this.page});
  VideoSuccessState cloneWith({int page, VideoDTO videoDTO}) {
    return VideoSuccessState(
        videoDTO: videoDTO ?? this.videoDTO, page: page ?? this.page);
  }
}

class VideoFailedState extends VideoState {
  String error;
  VideoFailedState({@required this.error});
}

class NoVideoState extends VideoState {}
