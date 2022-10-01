part of 'sign_up_bloc.dart';


class SignUpState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isFormValid;
  final bool isLoading;
  final String msg;
  final FormSubmissionStatus formStatus;

   const SignUpState(   {
    this.email = '',
    this.password = '',
    this.isEmailValid = true,
    this.isPasswordValid = true,
    this.confirmPassword = '',
    this.isConfirmPasswordValid = true,
    this.isFormValid = true,
     this.isLoading = false,
    this.formStatus = const InitialFormStatus(),
     this.msg = ''
  });

  SignUpState copyWith(
      {String? name,
        String? email,
        String? password,
        String? confirmPassword,
        bool? isEmailValid,
        bool? isPasswordValid,
        bool? isConfirmPasswordValid,
        bool? isFormValid,
        bool? isLoading,
        FormSubmissionStatus? formSubmissionStatus,
        String? msg
      }) {
    return SignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
        isFormValid: isFormValid ?? this.isFormValid,
        isLoading: isLoading ?? this.isLoading,
        formStatus: formSubmissionStatus ?? formStatus,
        msg: msg ?? this.msg
    );
  }


  @override
  List<Object?> get props => [
    email,
    password,
    confirmPassword,
    isEmailValid,
    isPasswordValid,
    isConfirmPasswordValid,
    isFormValid,
    isLoading,
    formStatus,
    msg
  ];
}
