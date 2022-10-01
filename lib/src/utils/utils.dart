import 'package:restaurant_booking_app/src/utils/constant.dart';

class Utils{

  static bool isEmailValid(String email) {
    return Constant.emailRegExp.hasMatch(email);
  }
  static bool isPasswordValid(String password) {
    return Constant.passwordRegExp.hasMatch(password);
  }

}