part of 'upload_bloc.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object> get props => [];
}

class UploadInitial extends UploadState {}

class UploadLoadingState extends UploadState {}

class UploadSuccessState extends UploadState {}

class UploadFailedState extends UploadState {}
