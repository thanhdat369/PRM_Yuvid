import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'follow_user_event.dart';
part 'follow_user_state.dart';

class FollowUserBloc extends Bloc<FollowUserEvent, FollowUserState> {
  FollowUserBloc() : super(FollowUserInitial());

  @override
  Stream<FollowUserState> mapEventToState(
    FollowUserEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
