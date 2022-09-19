import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_booking_app/src/theme/app_colors.dart';
import 'package:restaurant_booking_app/src/theme/app_theme.dart';

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