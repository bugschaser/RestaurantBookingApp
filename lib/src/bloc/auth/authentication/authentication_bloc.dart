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
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is AppStarted) {
        emit(AuthenticationLoading());
        try{
          // a simulated delay
          await Future.delayed(const Duration(milliseconds: 500)); // a simulated delay
          final currentUser = await _userRepository.getAuthUser();

          if (currentUser != null) {
            add(UserLoggedIn(user: currentUser));
          } else {
            emit(AuthenticationNotAuthenticated());
          }

        }catch(e){
          emit(AuthenticationFailure(message: e.toString()));
        }
        // emit(AuthenticationInitial());
      }
      if(event is UserLoggedIn){
        emit(AuthenticationAuthenticated(user: event.user));
      }

      if(event is UserLoggedOut){
        await _userRepository.signOut();
        emit(AuthenticationNotAuthenticated());
      }

    });
  }



}
