import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_booking_app/src/model/user.dart';
import 'package:restaurant_booking_app/src/repositories/user_repository.dart';
import 'package:restaurant_booking_app/src/utils/constant.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const LoginState());


  Stream<LoginState> mapEventToState(LoginEvent event) async*{

    if(event is EmailChanged){
      yield state.copyWith(
        email: event.email,
        isEmailValid: _isEmailValid(event.email),
        isFormValidateSuccessful: false,
        isFormValid: false,
        isFormValidateFailed: false,
      );
    }

    if(event is PasswordChanged){
      yield state.copyWith(
        password: event.password,
        isPasswordValid: _isPasswordValid(event.password),
        isFormValidateSuccessful: false,
        isFormValid: false,
        isFormValidateFailed: false,
      );
    }

    if(event is RememberMeUpdated){
      yield state.copyWith(
        isRememberMeChecked: event.rememberMe
      );
    }

    if(event is LoginSubmitted){
      yield* _mapFormSubmittedToState(event);
    }
    if(event is GoogleLoginSubmitted){
      yield* _mapGoogleLoginSubmittedToState(event);
    }
    if(event is FacebookLoginSubmitted){
      yield* _mapFacebookLoginSubmittedToState(event);
    }

  }

  bool _isEmailValid(String email) {
    return Constant.emailRegExp.hasMatch(email);
  }
  bool _isPasswordValid(String password) {
    return Constant.passwordRegExp.hasMatch(password);
  }

  _mapFormSubmittedToState(LoginSubmitted event) async {
    LoginState.loading();
    if(state.isFormValid){
       dynamic result = await _userRepository.signInWithEmail(email: state.email,
            password: state.password);
       if(result is User){
         state.copyWith(
           isLoading: false,
           isFormValid: true,
           isFormValidateFailed: false,
           isFormValidateSuccessful: true
         );
       }
       else if(result is String){
         state.copyWith(
             isLoading: false,
             errorMessage: result,
             isFormValid: false,
             isFormValidateFailed: true
         );
       }
    }else{
      state.copyWith(
          isLoading: false,
          isFormValid: false,
          isFormValidateFailed: true,
      );
    }
  }

  _mapGoogleLoginSubmittedToState(GoogleLoginSubmitted event) async {
    LoginState.loading();
    dynamic result = await _userRepository.signInWithGoogle();
    if(result is User){
      state.copyWith(
          isLoading: false,
          isFormValid: true,
          isFormValidateFailed: false,
          isFormValidateSuccessful: true
      );
    }
    else if(result is String){
      state.copyWith(
          isLoading: false,
          errorMessage: result,
          isFormValid: false,
          isFormValidateFailed: true
      );
    }
  }

  _mapFacebookLoginSubmittedToState(FacebookLoginSubmitted event) async {
    dynamic result = await _userRepository.signInWithFacebook();
    if(result is User){
      state.copyWith(
          isLoading: false,
          isFormValid: true,
          isFormValidateFailed: false,
          isFormValidateSuccessful: true
      );
    }
    else if(result is String){
      state.copyWith(
          isLoading: false,
          errorMessage: result,
          isFormValid: false,
          isFormValidateFailed: true
      );
    }
  }


}
