part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileEvent extends ProfileEvent {
  final int accountId;
  FetchProfileEvent({@required this.accountId});

  @override
  List<Object> get props => [];
}
