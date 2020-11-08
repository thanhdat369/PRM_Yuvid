part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileInitEvent extends EditProfileEvent {}

class EditProfileClickEvent extends EditProfileEvent {
  AccountEditDTO accountEditDTO;
  EditProfileClickEvent({this.accountEditDTO});
}
