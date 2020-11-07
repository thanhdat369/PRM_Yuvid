import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prm_yuvid/blocs/login/login_bloc.dart';
import 'package:prm_yuvid/blocs/video/load/video_bloc.dart';
import 'package:prm_yuvid/models/videoDTO.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadInitial());

  @override
  Stream<UploadState> mapEventToState(
    UploadEvent event,
  ) async* {
    if (event is UploadVideoClickEvent) {
      // yield UploadSuccessState();
    }
  }
}
