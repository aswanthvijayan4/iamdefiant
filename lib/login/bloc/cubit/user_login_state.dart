part of 'user_login_cubit.dart';

// abstract class UserLoginState extends Equatable {
//   const UserLoginState();

//   @override
//   List<Object> get props => [];
// }

// class UserLoginInitial extends UserLoginState {}

abstract class UserLoginState {
  const UserLoginState();

  @override
  List<Object> get props => [];
}

class UserLoginInitial extends UserLoginState {}

class UserLoginFetching extends UserLoginState {}

class UserLoginReady extends UserLoginState {
  final List data;
  final String baseUrl;
  UserLoginReady({this.data,this.baseUrl});
}

class UserLoginFetchReady extends UserLoginState {}

class UserLoginEmpty extends UserLoginState {}

class UserLoginRefreshing extends UserLoginState {}

class UserLoginFetchError extends UserLoginState {}
