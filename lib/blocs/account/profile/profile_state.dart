part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileFailedState extends ProfileState {
  final String message;
  ProfileFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileSuccessState extends ProfileState {
  final AccountDTO dto;
  // final String username;
  // ProfileSuccessState({@required this.id, @required this.username});
  ProfileSuccessState({@required this.dto});

  @override
  List<Object> get props => [];
}
