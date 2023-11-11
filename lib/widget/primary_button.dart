import 'package:flick_admin_panel/theme/colors.dart';
import 'package:flick_admin_panel/theme/text_style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  const PrimaryButton({
    super.key,
    this.onTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xff196F3D),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title!,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1.copyWith(
              fontSize: 18,
              color: AppColors.primaryWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
