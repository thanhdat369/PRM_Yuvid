import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/mock/mock_session.dart';
import 'package:prm_yuvid/repositories/account_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AccountRepository accountRepo;

  LoginBloc() : super(LoginInitial()) {
    this.accountRepo = AccountRepository();
  }

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is LoginButtonPressEvent) {
        yield LoginLoadingState();
        var user = await accountRepo.login(event.username, event.password);
        MockSession.id = user.id;
        yield LoginSuccessState(id: user.id);
      }
    } catch (e) {
      if (e.toString().contains("XMLHttp")) {
        yield LoginFailedState(message: "No Internet connection");
      } else
        yield LoginFailedState(message: e.toString().substring(10));
    }
    // TODO: implement mapEventToState
  }
}
