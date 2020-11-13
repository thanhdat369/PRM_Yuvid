part of 'search_account_bloc.dart';

abstract class SearchAccountEvent extends Equatable {
  const SearchAccountEvent();

  @override
  List<Object> get props => [];
}

class SearchAccountClickEvent extends SearchAccountEvent {
  String searchStr;
  SearchAccountClickEvent({this.searchStr});
}
