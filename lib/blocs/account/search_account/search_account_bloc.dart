import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prm_yuvid/models/accountDTO.dart';
import 'package:prm_yuvid/repositories/account_repo.dart';

part 'search_account_event.dart';
part 'search_account_state.dart';

class SearchAccountBloc extends Bloc<SearchAccountEvent, SearchAccountState> {
  AccountRepository _accountRepository;

  SearchAccountBloc() : super(SearchAccountInitial()) {
    _accountRepository = AccountRepository();
  }
  SearchAccountState get initialState => SearchAccountInitial();
  @override
  Stream<SearchAccountState> mapEventToState(
    SearchAccountEvent event,
  ) async* {
    if (event is SearchAccountClickEvent) {
      yield SearchAccountLoadingState();
      List<AccountDTO> list =
          await _accountRepository.getAccountByName(event.searchStr);
      yield SearchAccountSuccessState(list_dto: list);
    }
  }
}
