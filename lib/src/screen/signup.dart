import 'package:flutter/material.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

import 'package:restaurant_booking_app/src/widget/authenticate_widget.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/constant.dart';
import '../widget/form_custom_text_field.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _confirmPasswordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Constant.appBarHeight,
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height-100,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 20
                            ),
                            decoration: BoxDecoration(
                                color: AppColor.lightBlueColor,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text('SignUp',
                                    style: AppTheme.lightTheme.textTheme.headline5?.copyWith(
                                        color: AppColor.navyBlueColor,
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('Email',
                                  style: AppTheme.lightTheme.textTheme.bodyText1?.copyWith(
                                    color: AppColor.purpleColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FormCustomTextField(
                                    textEditingController: _emailTextEditingController
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text('Password',
                                  style: AppTheme.lightTheme.textTheme.bodyText1?.copyWith(
                                    color: AppColor.purpleColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FormCustomTextField(
                                  textEditingController: _passwordTextEditingController,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text('Confirm Password',
                                  style: AppTheme.lightTheme.textTheme.bodyText1?.copyWith(
                                    color: AppColor.purpleColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FormCustomTextField(
                                  textEditingController: _confirmPasswordTextEditingController,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                primary: AppColor.mediumBlueColor,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                fixedSize: const Size.fromWidth(double.maxFinite)
                            ),
                            child: const Text('SIGN UP',),
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
                              Text.rich(TextSpan(
                                  children: [
                                    TextSpan(text: 'Already have an account ?',
                                        style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                                            color: AppColor.navyBlueColor
                                        )
                                    ),
                                    WidgetSpan(
                                        alignment:  ui.PlaceholderAlignment.middle,
                                        child: TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            },
                                          child: Text('LogIn',
                                            style: AppTheme.lightTheme.textTheme.bodyText1?.copyWith(
                                                color: AppColor.mediumBlueColor,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ))
                                  ]
                              )),
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

    );
  }

}
