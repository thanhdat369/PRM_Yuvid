import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/repositories/account_repo.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  AccountRepository accountRepo;
  EditProfileBloc() : super(EditProfileInitial()) {
    accountRepo = AccountRepository();
  }
  EditProfileState get initialState => EditProfileInitial();
  @override
  Stream<EditProfileState> mapEventToState(
    EditProfileEvent event,
  ) async* {
    if (event is EditProfileClickEvent) {
      yield EditProfileLoadingState();
      bool isSuccess = await accountRepo.editProfile(event.accountEditDTO);
      if (isSuccess) {
        yield EditProfileSuccessState();
      } else {
        yield EditProfileFailedState();
      }
    }
  }
}
