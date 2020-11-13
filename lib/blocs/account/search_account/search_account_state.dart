part of 'search_account_bloc.dart';

abstract class SearchAccountState extends Equatable {
  const SearchAccountState();

  @override
  List<Object> get props => [];
}

class SearchAccountInitial extends SearchAccountState {}

class SearchAccountLoadingState extends SearchAccountState {}

class SearchAccountFailedState extends SearchAccountState {
  final String message;
  SearchAccountFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}

class SearchAccountSuccessState extends SearchAccountState {
  final List<AccountDTO> list_dto;
  // final String username;
  // SearchAccountSuccessState({@required this.id, @required this.username});
  SearchAccountSuccessState({@required this.list_dto});

  @override
  List<Object> get props => [];
}
