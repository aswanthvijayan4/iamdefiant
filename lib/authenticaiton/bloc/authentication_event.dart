part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationStateChanged extends AuthenticationEvent {
  final AuthenticationDetail authenticationDetail;
  final String branch;
  AuthenticationStateChanged(
      {@required this.authenticationDetail, this.branch});
  @override
  List<Object> get props => [authenticationDetail];
}

class AuthenticationGoogleStarted extends AuthenticationEvent {}

class AuthenticationExited extends AuthenticationEvent {}
