import 'package:flutter/material.dart';
import 'package:restaurant_booking_app/src/theme/app_colors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.whiteColor,
      child: const Center(child:  CircularProgressIndicator()),
    );
  }
}
