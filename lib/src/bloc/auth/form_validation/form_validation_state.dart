part of 'form_validation_bloc.dart';

class FormValidationState extends Equatable {
  final String name;
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isRememberMeChecked;
  final bool isFormValid;
  final bool isLoading;
  final String errorMessage;
  final bool isFormValidateFailed;
  final bool isFormValidateSuccessful;

  const FormValidationState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.isEmailValid = true,
    this.isPasswordValid = true,
    this.isRememberMeChecked = false,
    this.isFormValid = true,
    this.isLoading = false,
    this.errorMessage = '',
    this.isFormValidateFailed = false,
    this.isFormValidateSuccessful = true,
  });

  FormValidationState copyWith(
      {String? name,
        String? email,
        String? password,
        bool? isEmailValid,
        bool? isPasswordValid,
        bool? isRememberMeChecked,
        bool? isFormValid,
        bool? isLoading,
        String? errorMessage,
        bool? isFormValidateFailed,
        bool? isFormValidateSuccessful}) {
    return FormValidationState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isRememberMeChecked: isRememberMeChecked ?? this.isRememberMeChecked,
        isFormValid: isFormValid ?? this.isFormValid,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
        isFormValidateSuccessful:
        isFormValidateSuccessful ?? this.isFormValidateSuccessful);
  }

  factory FormValidationState.loading() {
    return const FormValidationState().copyWith(
        isEmailValid: true,
        isPasswordValid: true,
        isFormValid: true,
        isLoading: true,
        errorMessage: '');
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    isEmailValid,
    isPasswordValid,
    isRememberMeChecked,
    isFormValid,
    isFormValidateFailed,
    isFormValidateSuccessful
  ];
}
