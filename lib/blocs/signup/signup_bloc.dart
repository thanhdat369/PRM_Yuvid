import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/repositories/account_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AccountRepository accountRepo;
  
  SignupBloc() : super(SignupInitial()){
    this.accountRepo = AccountRepository();
  }

  @override
  // TODO: implement initialState
  SignupState get initialState => SignupInitial();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    try {
      if (event is SignupButtonPressEvent) {
        yield SignupLoadingState();
        var user = await accountRepo.signup(event.dto);
        print("--------------");
        yield SignupSuccessState();
      }
    } catch (e) {
      yield SignupFailedState(message: e.toString().substring(10));
    }
    // TODO: implement mapEventToState
  }
}
