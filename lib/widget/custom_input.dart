import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomTextInput extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool readOnly;
  final Widget? suffixWidget;
  const CustomTextInput({super.key, required this.title, this.controller, this.readOnly = false, this.suffixWidget});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      controller: controller ?? TextEditingController(),
      style: TextStyle(color: AppColors.primaryWhite),
      decoration: InputDecoration(
        hintText: title,
        filled: true,
        fillColor: AppColors.lightBlackColor,
        suffixIcon: suffixWidget,
        hintStyle: TextStyle(color: AppColors.primaryGrey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryWhite),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryWhite),
        ),
      ),
    );
  }
}
