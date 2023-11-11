import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';

class CustomInput extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final int ? maxLines;
  final bool  enabled;
  const CustomInput({
    Key? key,
    this.validator,
    this.controller,
    this.keyboardType,
    this.hintText, this.maxLines, this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(color: AppColors.primaryWhite),
        decoration: InputDecoration(
          enabled: enabled,
          filled: true,
          fillColor: AppColors.lightBlackColor,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.primaryWhite),

          contentPadding: const EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // validations
        validator: validator);
  }
}
