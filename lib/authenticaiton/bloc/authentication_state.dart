part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailiure extends AuthenticationState {
  final String message;
  AuthenticationFailiure({
    @required this.message,
  });
  @override
  List<Object> get props => [message];
}

class AuthenticationSuccess extends AuthenticationState {  
  final AuthenticationDetail authenticationDetail;
  final String branch;
  AuthenticationSuccess({@required this.authenticationDetail, this.branch});
  @override
  List<Object> get props => [authenticationDetail];
}
