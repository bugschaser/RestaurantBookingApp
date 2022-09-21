part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

//Fired just after the app is launched
class AppStarted extends AuthenticationEvent{}

// Fired when a user has successfully logged in
class UserLoggedIn extends AuthenticationEvent{
  final UserModel user;
  const UserLoggedIn({required this.user});
  @override
  List<Object> get props => [user];
}

//Fired when a user has been logged out
class UserLoggedOut extends AuthenticationEvent{}
