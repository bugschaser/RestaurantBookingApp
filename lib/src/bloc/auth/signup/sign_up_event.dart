part of 'sign_up_bloc.dart';

enum Status { signIn, signUp }

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object> get props => [];
}

class EmailChanged extends SignUpEvent{
  final String email;
  const EmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}
class PasswordChanged extends SignUpEvent{
  final String password;
  const PasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends SignUpEvent{
  final String confirmPassword;
  const ConfirmPasswordChanged({required this.confirmPassword});
  @override
  List<Object> get props => [confirmPassword];
}

class FormSubmitted extends SignUpEvent {
  final bool isFormValidate;
  final Status status;
  const FormSubmitted( {required this.isFormValidate, required this.status});
  @override
  List<Object> get props => [isFormValidate,status];
}

class FormSucceed extends SignUpEvent {}