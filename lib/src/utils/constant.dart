import 'dart:io';

class Constant {
  static double appBarHeight = Platform.isAndroid ? 56.0 : 45.0 ;
  static const String appName = 'Restaurant Booking';

  // Collection:
  // ignore: constant_identifier_names
  static const String USERS = 'users';

  // constant
  static final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp passwordRegExp = RegExp(
    r"([a-zA-Z0-9]*.{8,})$",
  );

}