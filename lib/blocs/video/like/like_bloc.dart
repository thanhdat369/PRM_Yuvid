import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prm_yuvid/repositories/likes_repo.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikesRepository _likesRepository;
  LikeBloc() : super(LikeInitial()) {
    _likesRepository = LikesRepository();
  }
  LikeState get initialState => LikeInitial();
  @override
  Stream<LikeState> mapEventToState(
    LikeEvent event,
  ) async* {
    if (event is LikeVideoClickEvent) {
      yield LikeLoadingState();
      bool isSuccess = false;
      if (event.isClickLike) {
        isSuccess =
            await _likesRepository.likeVideo(event.videoID, event.userID);
      } else {
        await _likesRepository.unLikeVideo(event.videoID, event.userID);
      }
      if (isSuccess) {
        yield LikeSuccessState();
      } else {
        yield LikeFailedState();
      }
    }
  }
}
