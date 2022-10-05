import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_booking_app/src/bloc/auth/form_submission_status.dart';
import 'package:restaurant_booking_app/src/model/user.dart';
import 'package:restaurant_booking_app/src/repositories/user_repository.dart';
import 'package:restaurant_booking_app/src/utils/utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository, super(const SignUpState()) {
    on<SignUpEvent>((event, emit) async {
      // TODO: implement event handler
      if(event is EmailChanged){
        emit(state.copyWith(
          email: event.email,
          isEmailValid: Utils.isEmailValid(event.email),
        ));
      }
      else if(event is PasswordChanged){
        emit(state.copyWith(
          password: event.password,
          isPasswordValid: Utils.isPasswordValid(event.password),
          isFormValid: false,
        ));
      }
      else if(event is ConfirmPasswordChanged){
        emit(state.copyWith(
          confirmPassword: event.confirmPassword,
          isConfirmPasswordValid: state.password == event.confirmPassword,
          isFormValid: false,
          isLoading: false
        ));
      }
      else if(event is  FormSubmitted){
        emit(state.copyWith(
          isFormValid: event.isFormValidate,
          formSubmissionStatus: FormSubmitting()
        ));

        try{
          if(state.isFormValid) {
            emit(state.copyWith(
                isLoading: true
            ));
            dynamic result;
            if(event.status == Status.signUp){
              result = await _userRepository.createUserWithEmail(
                  email: state.email, password: state.password);
            }
            if(event.status == Status.signIn){
              result = await _userRepository.signInWithEmail(
                  email: state.email, password: state.password);
            }
            if(result == null){
              emit(state.copyWith(
                  isLoading: false,
                  isFormValid: false,
                  formSubmissionStatus: SubmissionFailed(result)
              ));
            }
            else if(result is UserModel){
              emit(state.copyWith(
                  isLoading: false,
                  isFormValid: false,
                  formSubmissionStatus: SubmissionSuccess(),
              ));
            }else if(result is String){
              emit(state.copyWith(
                  isLoading: false,
                  isFormValid: false,
                  formSubmissionStatus: SubmissionFailed(result),
                  msg:result

              ));
            }
          }
        }catch(e){
          emit(
              state.copyWith(
                  formSubmissionStatus: SubmissionFailed(e.toString()),
                  isLoading: false,
                  isFormValid: false
              ));
        }
      }

    });
  }
}
