import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_booking_app/src/screen/signup.dart';
import 'package:restaurant_booking_app/src/theme/app_colors.dart';
import 'package:restaurant_booking_app/src/theme/app_theme.dart';
import 'package:restaurant_booking_app/src/widget/form_custom_text_field.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

import '../utils/constant.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  bool _isRememberMe = false;

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
                              child: Text('LogIn',
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
                              height: 10,
                            ),
                          ],
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
                                  onChanged: (value){
                                    setState(() {
                                      _isRememberMe = true;
                                    });
                                  },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Text('Remember me',style: AppTheme.lightTheme.textTheme.subtitle2?.copyWith(
                                color: AppColor.purpleColor
                              ),)
                            ],
                          ),
                          TextButton(
                            onPressed: (){},
                              child: Text('Forgot Password?',
                               style: AppTheme.lightTheme.textTheme.bodyText1?.copyWith(
                                 color: AppColor.navyBlueColor
                               ),
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
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.mediumBlueColor,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          fixedSize: const Size.fromWidth(double.maxFinite)
                        ),
                        child: const Text('LOGIN',),
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
                              TextSpan(text: 'Don\'t have an account ?',
                               style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                                 color: AppColor.navyBlueColor
                               )
                              ),
                              WidgetSpan(
                                  alignment:  ui.PlaceholderAlignment.middle,
                                  child: TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpPage()));
                                },
                                child: Text('Sign Up',
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

  Widget orWidget(){
    return Row(
      children: [
        const Expanded(child: Divider(
          color: AppColor.purpleColor,
          thickness: 1.0,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8),
          child: Text('OR',
            style: AppTheme.lightTheme.textTheme.bodyText1?.copyWith(
              color: AppColor.purpleColor,
            ),
          ),
        ),
        const Expanded(child: Divider(
          color: AppColor.purpleColor,
          thickness: 1.0,
        )),
      ],
    );
  }
  Widget socialRowWidget({GestureTapCallback? onGoogleIconTap,
    GestureTapCallback? onFacebookIconTap,GestureTapCallback? onAppleIconTap}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onGoogleIconTap, // Handle your callback.
          splashColor: AppColor.red.withOpacity(0.5),
          borderRadius: BorderRadius.circular(50),
          child: Ink(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/ic_google.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: onFacebookIconTap, // Handle your callback.
          splashColor: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(50),
          child: Ink(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/ic_facebook.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        if(Platform.isIOS)...[

          const SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: onAppleIconTap, // Handle your callback.
            splashColor: Colors.blue.withOpacity(0.5),
            borderRadius: BorderRadius.circular(50),
            child: Ink(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/ic_apple.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }

}
