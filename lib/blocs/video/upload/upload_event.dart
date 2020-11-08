part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadVideoClickEvent extends UploadEvent {
  VideoUploadDTO videoUploadDTO;
  UploadVideoClickEvent({this.videoUploadDTO});
}
