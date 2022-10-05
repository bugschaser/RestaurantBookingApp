import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/src/bloc/auth/authentication/authentication_bloc.dart';
import 'package:restaurant_booking_app/src/bloc/auth/signup/sign_up_bloc.dart';
import 'package:restaurant_booking_app/src/repositories/user_repository.dart';
import 'package:restaurant_booking_app/src/screen/home_screen.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

import 'package:restaurant_booking_app/src/widget/authenticate_widget.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/constant.dart';
import '../widget/form_custom_text_field.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.lightBackgroundColor,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => SignUpBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context)),
            child: MultiBlocListener(
              listeners: [
                BlocListener<SignUpBloc, SignUpState>(
                    listenWhen: (previous, current) =>
                    previous.formStatus != current.formStatus,
                    listener: (context, state) {
                      if (state.isFormValid && !state.isLoading) {
                        context.read<AuthenticationBloc>().add(AppStarted());

                      } else if (state.msg.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.msg)));
                      }
                    }),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationAuthenticated) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                              (Route<dynamic> route) => false);
                    }
                  },
                ),
              ],
              child: Column(
                children: [
                  SizedBox(
                    height: Constant.appBarHeight,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Container(
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  decoration: BoxDecoration(
                                      color: AppColor.lightBlueColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Form(
                                    key: _signUpFormKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            'SignUp',
                                            style: AppTheme
                                                .lightTheme.textTheme.headline5
                                                ?.copyWith(
                                                color: AppColor.navyBlueColor,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        _emailTextField(),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        _passwordTextField(),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        _confirmPasswordTextField(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                             _submitButton(),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Column(
                                  children: [
                                    orWidget(),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'Already have an account ?',
                                          style: AppTheme
                                              .lightTheme.textTheme.labelLarge
                                              ?.copyWith(
                                              color: AppColor.navyBlueColor)),
                                      WidgetSpan(
                                          alignment: ui.PlaceholderAlignment.middle,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'LogIn',
                                              style: AppTheme
                                                  .lightTheme.textTheme.bodyText1
                                                  ?.copyWith(
                                                  color: AppColor.mediumBlueColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ))
                                    ])),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    socialRowWidget()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _emailTextField(){
    return Column(
      children: [
        Text(
          'Email',
          style: AppTheme
              .lightTheme.textTheme.bodyText1
              ?.copyWith(
            color: AppColor.purpleColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return FormCustomTextField(
              onChange: (emailValue) {
                context.read<SignUpBloc>().add(
                    EmailChanged(
                        email: emailValue ?? ''));
              },
              validator: (email) {
                if (!state.isEmailValid) {
                  return "Please enter a correct email address.";
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _passwordTextField(){
    return Column(
      children: [
        Text(
          'Password',
          style: AppTheme
              .lightTheme.textTheme.bodyText1
              ?.copyWith(
            color: AppColor.purpleColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return FormCustomTextField(
              onChange: (passwordValue) {
                context.read<SignUpBloc>().add(
                    PasswordChanged(
                        password:
                        passwordValue ?? ''));
              },
              validator: (password) {
                if (!state.isPasswordValid) {
                  return "Password length must have at least 8 characters.";
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _confirmPasswordTextField(){
    return Column(
      children: [
        Text(
          'Confirm Password',
          style: AppTheme
              .lightTheme.textTheme.bodyText1
              ?.copyWith(
            color: AppColor.purpleColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return FormCustomTextField(
              onChange: (confirmPassword) {
                context.read<SignUpBloc>().add(
                    ConfirmPasswordChanged(
                        confirmPassword:
                        confirmPassword ?? ''));
              },
              validator: (email) {
                if (!state.isConfirmPasswordValid) {
                  return "Both password and confirm password must be same.";
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }

  _submitButton() {
    return  BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 10),
          child: ElevatedButton(
            onPressed: () {
              context.read<SignUpBloc>().add(
                  FormSubmitted(
                      isFormValidate: _signUpFormKey
                          .currentState
                          ?.validate() ??
                          false));
            },
            style: ElevatedButton.styleFrom(
                primary: AppColor.mediumBlueColor,
                padding: const EdgeInsets.symmetric(
                    vertical: 15),
                fixedSize:
                const Size.fromWidth(double.maxFinite)),
            child: state.isLoading
                ? const CircularProgressIndicator(
              color: AppColor.whiteColor,
            )
                : const Text(
              'SIGN UP',
            ),
          ),
        );
      },
    );
  }


}
