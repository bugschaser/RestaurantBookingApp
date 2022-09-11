import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FormCustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  const FormCustomTextField({Key? key,
    required this.textEditingController, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        style: AppTheme.lightTheme.textTheme.bodyText1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.amber,
                  width: 2.0
              ),
              gapPadding: 2.0
          ),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
              gapPadding: 2.0
          ),
        ),
      validator: validator,
      );
  }
}
