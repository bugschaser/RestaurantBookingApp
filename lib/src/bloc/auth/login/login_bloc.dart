import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_booking_app/src/model/user.dart';
import 'package:restaurant_booking_app/src/repositories/user_repository.dart';
import 'package:restaurant_booking_app/src/utils/utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository, super(const LoginState()) {
    on<LoginEvent>((event, emit) async {
      // TODO: implement event handler
      if(event is EmailChanged){
         emit(state.copyWith(
          email: event.email,
          isEmailValid: Utils.isEmailValid(event.email),
          isFormValidateSuccessful: false,
          isFormValid: false,
          isFormValidateFailed: false,
        ));
      }

      if(event is PasswordChanged){
        emit(state.copyWith(
          password: event.password,
          isPasswordValid: Utils.isPasswordValid(event.password),
          isFormValidateSuccessful: false,
          isFormValid: false,
          isFormValidateFailed: false,
        ));
      }

      if(event is RememberMeUpdated){
        emit(state.copyWith(
            isRememberMeChecked: event.rememberMe
        ));
      }

      if(event is LoginButtonSubmitted){
        LoginState.loading();
        if(state.isFormValid){
          dynamic result = await _userRepository.signInWithEmail(email: state.email,
              password: state.password);
          if(result is UserModel){
            emit(state.copyWith(
                isLoading: false,
                isFormValid: true,
                isFormValidateFailed: false,
                isFormValidateSuccessful: true
            ));
          }
          else if(result is String){
            emit(state.copyWith(
                isLoading: false,
                errorMessage: result,
                isFormValid: false,
                isFormValidateFailed: true
            ));
          }
        }else{
          emit(state.copyWith(
            isLoading: false,
            isFormValid: false,
            isFormValidateFailed: true,
          ));
        }
      }

      if(event is GoogleButtonSubmitted){
        LoginState.loading();
        dynamic result = await _userRepository.signInWithGoogle();
        if(result is UserModel){
          emit(state.copyWith(
              isLoading: false,
              isFormValid: true,
              isFormValidateFailed: false,
              isFormValidateSuccessful: true
          ));
        }
        else if(result is String){
          emit(state.copyWith(
              isLoading: false,
              errorMessage: result,
              isFormValid: false,
              isFormValidateFailed: true
          ));
        }
      }
      if(event is FacebookButtonSubmitted){
        dynamic result = await _userRepository.signInWithFacebook();
        if(result is UserModel){
          emit(state.copyWith(
              isLoading: false,
              isFormValid: true,
              isFormValidateFailed: false,
              isFormValidateSuccessful: true
          ));
        }
        else if(result is String){
          emit(state.copyWith(
              isLoading: false,
              errorMessage: result,
              isFormValid: false,
              isFormValidateFailed: true
          ));
        }
      }
      if(event is FormSucceed){
        emit(state.copyWith(isFormValidateSuccessful: true));
      }
    });
  }


}
