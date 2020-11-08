part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginButtonPressEvent extends LoginEvent {
  final String username, password;
  LoginButtonPressEvent({@required this.username, @required this.password});
  
  @override
  List<Object> get props => [];
}
