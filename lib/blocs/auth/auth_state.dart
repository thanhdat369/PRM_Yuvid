part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  AccountDTO accountDTO;

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return accountDTO.username;
  }
}

class AuthFailed extends AuthState {}
