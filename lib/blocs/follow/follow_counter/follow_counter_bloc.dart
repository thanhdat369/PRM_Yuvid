import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/repositories/follow_repo.dart';

part 'follow_counter_event.dart';
part 'follow_counter_state.dart';

class FollowCounterBloc extends Bloc<FollowCounterEvent, FollowCounterState> {
  FollowRepo followRepo;
  FollowCounterBloc() : super(FollowCounterInitial()) {
    followRepo = FollowRepo();
  }

  @override
  Stream<FollowCounterState> mapEventToState(
    FollowCounterEvent event,
  ) async* {
    try {
      if (event is FetchFollowCountertEvent) {
        yield FollowCounterLoadingState();
        var listFollower = await followRepo.getAllFollowers(event.userID);
        var listFollowing = await followRepo.getAllFollowing(event.userID);
        yield FollowCounterSuccessState(
            followerList: listFollower, followingList: listFollowing);
      }
    } catch (e) {
      print(e);
      yield FollowCounterFailedState(message: e.toString().substring(10));
    }
  }
}
