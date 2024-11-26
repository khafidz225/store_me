part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  BuildContext context;
  String username;
  String password;

  AuthLoginEvent(
      {required this.context, required this.username, required this.password});

  @override
  List<Object> get props => [context, username, password];
}
