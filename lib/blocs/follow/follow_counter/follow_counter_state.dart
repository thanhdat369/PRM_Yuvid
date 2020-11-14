part of 'follow_counter_bloc.dart';

abstract class FollowCounterState extends Equatable {
  const FollowCounterState();

  @override
  List<Object> get props => [];
}

class FollowCounterInitial extends FollowCounterState {}

class FollowCounterLoadingState extends FollowCounterState {}

class FollowCounterFailedState extends FollowCounterState {
  final String message;
  FollowCounterFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}

class FollowCounterSuccessState extends FollowCounterState {
  final List<AccountDTO> followerList;
  final List<AccountDTO> followingList;

  // final String username;
  // LoginSuccessState({@required this.id, @required this.username});
  FollowCounterSuccessState(
      {@required this.followerList, @required this.followingList});

  @override
  List<Object> get props => [];
}
