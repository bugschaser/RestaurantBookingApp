
import 'package:equatable/equatable.dart';

import '../../model/user.dart';

abstract class AuthenticationEvent extends Equatable {

  const AuthenticationEvent();

  @override
  List<Object> get props => [];

}

//Fired just after the app is launched
class AppLoaded extends AuthenticationEvent{}

// Fired when a user has successfully logged in
class UserLoggedIn extends AuthenticationEvent{
  final User user;
  const UserLoggedIn({required this.user});
  @override
  List<Object> get props => [user];
}

//Fired when a user has been logged out
class UserLoggedOut extends AuthenticationEvent{}