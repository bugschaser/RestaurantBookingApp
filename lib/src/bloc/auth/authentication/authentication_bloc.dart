import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_booking_app/src/model/user.dart';
import 'package:restaurant_booking_app/src/repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial());

  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    if(event is AppStarted){
      yield* _mapAppLoadedToState(event);
    }
    if(event is UserLoggedIn){
      yield* _mapUserLoggedInToState(event);
    }
    if(event is UserLoggedOut){
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppStarted event) async* {
    yield AuthenticationLoading();
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // a simulated delay
      final currentUser = await _userRepository.getAuthUser();

      if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }

  }
  Stream<AuthenticationState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }
  Stream<AuthenticationState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    await _userRepository.signOut();
    yield AuthenticationNotAuthenticated();
  }
}
