import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/models/videoDTO.dart';
import 'package:prm_yuvid/repositories/video_repo.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoRepo _videoRepo;
  VideoBloc() : super(VideoInitial()) {
    _videoRepo = VideoRepo();
  }
  VideoState get initialState => VideoInitial();

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    if (event is VideoFetchEvent) {
      if (state is VideoInitial) {
        try {
          print("aaaaaaaaaaa");
          var video = await _videoRepo.getVideoByPage(1);
          yield VideoSuccessState(videoDTO: video, page: 1);
        } catch (e) {
          print(e);
          yield (VideoFailedState(
              error: "No more videos. Follow for more videos"));
        }
      }
    }
    if (event is VideoPagePressEvent) {
      int page = event.page;
      try {
        if (page > 0) {
          yield VideoInitial();
          var video = await _videoRepo.getVideoByPage(page);
          yield VideoSuccessState(videoDTO: video, page: page);
        } else {
          var video = await _videoRepo.getVideoByPage(1);
          yield VideoSuccessState(videoDTO: video, page: 1);
        }
      } catch (e) {
        print(e);
        yield (VideoFailedState(
            error: "No more videos. Follow for more videos"));
      }
    }
  }
}
