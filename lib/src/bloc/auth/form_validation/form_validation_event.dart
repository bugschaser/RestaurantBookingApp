part of 'form_validation_bloc.dart';

abstract class FormValidationEvent extends Equatable {
  const FormValidationEvent();
  @override
  List<Object> get props => [];
}

class EmailChanged extends FormValidationEvent{
  final String email;
  const EmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}
class PasswordChanged extends FormValidationEvent{
  final String password;
  const PasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}

class RememberMeUpdated extends FormValidationEvent{
  final bool rememberMe;
  const RememberMeUpdated({required this.rememberMe});
  @override
  List<Object> get props => [rememberMe];
}
class LoginButtonSubmitted extends FormValidationEvent {}

class GoogleButtonSubmitted extends FormValidationEvent {}

class FacebookButtonSubmitted extends FormValidationEvent {}

class AppleButtonSubmitted extends FormValidationEvent {}

class FormSucceed extends FormValidationEvent {}