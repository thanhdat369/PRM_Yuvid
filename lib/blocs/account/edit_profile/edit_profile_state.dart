part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileSuccessState extends EditProfileState {}

class EditProfileFailedState extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}
