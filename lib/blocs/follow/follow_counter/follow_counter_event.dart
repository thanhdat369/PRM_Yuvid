part of 'follow_counter_bloc.dart';

abstract class FollowCounterEvent extends Equatable {
  const FollowCounterEvent();

  @override
  List<Object> get props => [];
}

class FetchFollowCountertEvent extends FollowCounterEvent {
  final int userID;
  FetchFollowCountertEvent({@required this.userID});

  @override
  List<Object> get props => [];
}
