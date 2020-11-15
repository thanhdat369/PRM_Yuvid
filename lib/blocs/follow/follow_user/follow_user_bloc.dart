import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/repositories/follow_repo.dart';

part 'follow_user_event.dart';
part 'follow_user_state.dart';

class FollowUserBloc extends Bloc<FollowUserEvent, FollowUserState> {
  FollowRepo followRepo;
  FollowUserBloc() : super(FollowUserInitial()) {
    followRepo = FollowRepo();
  }

  @override
  Stream<FollowUserState> mapEventToState(
    FollowUserEvent event,
  ) async* {
    try {
      if (event is FetchFollowUserEvent) {
        yield FollowUserLoadingState();
        bool isFollow =
            await followRepo.isFollow(event.userSrcId, event.userDesId);
        if (isFollow) {
          yield FollowUserFollowingState();
        } else {
          yield FollowUserNotFollowingState();
        }
      } else if (event is ClickFollowUserEvent) {
        yield FollowUserLoadingState();
        bool isSuccess = false;
        if (event.mode == ClickFollowUserEvent.FOLLOW_MODE) {
          isSuccess = await followRepo.follow(event.userSrcId, event.userDesId);
          if (isSuccess) yield FollowUserFollowingState();
        } else if (event.mode == ClickFollowUserEvent.UNFOLLOW_MODE) {
          isSuccess =
              await followRepo.unfollow(event.userSrcId, event.userDesId);
          if (isSuccess) yield FollowUserNotFollowingState();
        }
        if (!isSuccess)
          yield FollowUserFailedState(message: "An error when click");
      }
    } catch (e) {
      yield FollowUserFailedState(message: e.toString());
      print(e);
    }
    // TODO: implement mapEventToState
  }
}
