import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prm_yuvid/repositories/account_repo.dart';

part 'editavt_event.dart';
part 'editavt_state.dart';

class EditavtBloc extends Bloc<EditavtEvent, EditavtState> {
  AccountRepository accountRepository;
  EditavtBloc() : super(EditavtInitial()) {
    accountRepository = AccountRepository();
  }
  EditavtState get initialState => EditavtInitial();
  @override
  Stream<EditavtState> mapEventToState(
    EditavtEvent event,
  ) async* {
    if (event is EditavtClickEvent) {
      yield EditavtLoadingState();
      bool isSuccess = await accountRepository.editAvt(event.imageFile);
      if (isSuccess) {
        yield EditavtSuccessState();
      } else {
        yield EditavtFailedState();
      }
    }
  }
}
