import 'package:flutter/material.dart';
import 'package:restaurant_booking_app/src/screen/login.dart';

import 'src/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Booking App',
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.lightTheme,
      home: const LoginForm(),
    );
  }
}
