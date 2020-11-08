part of 'signup_bloc.dart';

@immutable
abstract class SignupState extends Equatable{
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupFailedState extends SignupState {
  final String message;
  SignupFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}

class SignupSuccessState extends SignupState {
  // final int id;
  
  // SignupSuccessState({@required this.id});

  @override
  List<Object> get props => [];
}
