part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupInitEvent extends SignupEvent {
  @override
  List<Object> get props => [];
}

class SignupButtonPressEvent extends SignupEvent {

  AccountSignUpDTO dto = AccountSignUpDTO();

  SignupButtonPressEvent({@required this.dto});
  
  @override
  List<Object> get props => [];
}