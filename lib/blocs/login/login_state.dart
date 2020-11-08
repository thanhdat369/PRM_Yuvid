part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFailedState extends LoginState {
  final String message;
  LoginFailedState({@required this.message});

  @override
  List<Object> get props => [message];
}

class LoginSuccessState extends LoginState {
  final int id;
  // final String username;
  // LoginSuccessState({@required this.id, @required this.username});
  LoginSuccessState({@required this.id});

  @override
  List<Object> get props => [];
}
