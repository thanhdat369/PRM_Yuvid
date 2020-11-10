import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/repositories/video_repo.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  VideoRepo _videoRepo;

  UploadBloc() : super(UploadInitial()) {
    _videoRepo = VideoRepo();
  }
  UploadState get initialState => UploadInitial();
  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    if (event is UploadVideoClickEvent) {
      yield UploadLoadingState();
      bool isSucess = await _videoRepo.upload(event.videoUploadDTO);
      if (isSucess != null && isSucess) {
        yield UploadSuccessState();
      } else {
        yield UploadFailedState();
      }
    }
  }
}
