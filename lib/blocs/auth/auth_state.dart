part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthenticatedState extends AuthState {
  int id;
  AuthenticatedState(this.id);
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "id : $id";
  }
}

class UnAuthenticatedState extends AuthState {}
