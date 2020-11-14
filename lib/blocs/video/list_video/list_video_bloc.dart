import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/repositories/video_repo.dart';

part 'list_video_event.dart';
part 'list_video_state.dart';

class ListVideoBloc extends Bloc<ListVideoEvent, ListVideoState> {
  VideoRepo _videoRepo;
  ListVideoBloc() : super(ListVideoInitial()) {
    _videoRepo = VideoRepo();
  }

  @override
  Stream<ListVideoState> mapEventToState(
    ListVideoEvent event,
  ) async* {
    if (event is FetchListVideoEvent) {
      try {
        yield ListVideoLoadingState();
        if (event.mode == FetchListVideoEvent.LIKED_VIDEO_MODE) {
          List<VideoDTO> listVideo = await _videoRepo.getVideoLiked();
          yield ListVideoSuccessState(list_video: listVideo);
        } else if (event.mode == FetchListVideoEvent.USER_VIDEO_MODE) {
          List<VideoDTO> listVideo =
              await _videoRepo.getVideoByUserID(event.userID);
          yield ListVideoSuccessState(list_video: listVideo);
        } else if (event.mode == FetchListVideoEvent.FOLLOWING_VIDEO_MODE) {
          List<VideoDTO> listVideo = await _videoRepo.getVideoFollowing();
          yield ListVideoSuccessState(list_video: listVideo);
        }
      } catch (e) {
        yield ListVideoFailedState(message: e.toString());
        print(e);
      }
    }
  }
}
