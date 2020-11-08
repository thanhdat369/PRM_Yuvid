import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:prm_yuvid/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepo authRepo;
  AuthBloc() : super(AuthInitial()) {
    this.authRepo = AuthRepo();
  }
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStartedEvent) {
      try {
        var isSignedIn = await authRepo.isSignedIn();
        if (isSignedIn) {
          var id = await authRepo.getCurrentUser();
          yield AuthenticatedState(id);
        } else {
          yield UnAuthenticatedState();
        }
      } catch (e) {
        yield UnAuthenticatedState();
      }
    }
  }
}
