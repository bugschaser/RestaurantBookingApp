import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_booking_app/src/bloc/auth/login/login_bloc.dart';
import 'package:restaurant_booking_app/src/repositories/user_repository.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

import 'package:restaurant_booking_app/src/screen/signup.dart';
import 'package:restaurant_booking_app/src/theme/app_colors.dart';
import 'package:restaurant_booking_app/src/theme/app_theme.dart';
import 'package:restaurant_booking_app/src/widget/form_custom_text_field.dart';
import 'package:restaurant_booking_app/src/utils/constant.dart';
import 'package:restaurant_booking_app/src/widget/authenticate_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  bool _isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBackgroundColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context)),
          child: Column(
            children: [
              SizedBox(
                height: Constant.appBarHeight,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state.errorMessage.isNotEmpty) {
                      } else if (state.isFormValid && !state.isLoading) {
                        context.read<LoginBloc>().add(FormSucceed());
                      } else if (state.isFormValidateFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(Constant.textFixIssues)));
                      }
                    },
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
                              key: _loginFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      'LogIn',
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
                                  BlocBuilder<LoginBloc,
                                      LoginState>(
                                    buildWhen: (previous, current) =>
                                        previous.email != current.email,
                                    builder: (context, state) {
                                      return FormCustomTextField(
                                        textEditingController:
                                            _emailTextEditingController,
                                        onChange: (emailValue) {
                                          context
                                              .read<LoginBloc>()
                                              .add(EmailChanged(
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
                                  const SizedBox(
                                    height: 30,
                                  ),
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
                                  BlocBuilder<LoginBloc,
                                      LoginState>(
                                    builder: (context, state) {
                                      return FormCustomTextField(
                                        textEditingController:
                                            _passwordTextEditingController,
                                        onChange: (password) {
                                          context
                                              .read<LoginBloc>()
                                              .add(PasswordChanged(
                                                  password: password ?? ''));
                                        },
                                        validator: (email) {
                                          if (!state.isPasswordValid) {
                                            return "Password length must have at least 8 characters.";
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _isRememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _isRememberMe = true;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Text(
                                    'Remember me',
                                    style: AppTheme
                                        .lightTheme.textTheme.subtitle2
                                        ?.copyWith(color: AppColor.purpleColor),
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTheme.lightTheme.textTheme.bodyText1
                                      ?.copyWith(color: AppColor.navyBlueColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: AppColor.mediumBlueColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                fixedSize:
                                    const Size.fromWidth(double.maxFinite)),
                            child: const Text(
                              'LOGIN',
                            ),
                          ),
                        ),
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
                                    text: 'Don\'t have an account ?',
                                    style: AppTheme
                                        .lightTheme.textTheme.labelLarge
                                        ?.copyWith(
                                            color: AppColor.navyBlueColor)),
                                WidgetSpan(
                                    alignment: ui.PlaceholderAlignment.middle,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const SignUpPage()));
                                      },
                                      child: Text(
                                        'Sign Up',
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
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
