part of 'list_video_bloc.dart';

abstract class ListVideoState extends Equatable {
  const ListVideoState();

  @override
  List<Object> get props => [];
}

class ListVideoInitial extends ListVideoState {}

class ListVideoLoadingState extends ListVideoState {}

class ListVideoSuccessState extends ListVideoState {
  final List<VideoDTO> list_video;
  ListVideoSuccessState({this.list_video});
}

class ListVideoFailedState extends ListVideoState {
  final String message;
  ListVideoFailedState({this.message});
}
