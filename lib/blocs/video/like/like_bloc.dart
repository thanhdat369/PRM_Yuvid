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
    // TODO: implement mapEventToState
    print("0000000000000000000000000");
  }
}
