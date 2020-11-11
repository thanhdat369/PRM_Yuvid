import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/repositories/account_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AccountRepository _accountRepository;
  ProfileBloc() : super(ProfileInitial()) {
    _accountRepository = AccountRepository();
  }

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    try {
      if (event is FetchProfileEvent) {
        yield ProfileLoadingState();
        var dto = await _accountRepository.getAccountByID(event.accountId);
        print("--------------");
        yield ProfileSuccessState(dto: dto);
      }
    } catch (e) {
      yield ProfileFailedState(message: e.toString().substring(10));
    }
  }
}
