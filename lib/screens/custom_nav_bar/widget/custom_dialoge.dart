import 'package:flick_admin_panel/theme/app_text.dart';
import 'package:flick_admin_panel/theme/colors.dart';
import 'package:flick_admin_panel/theme/text_style.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.lightBlackColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.editTitle,
              style: AppTextStyles.heading1,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: AppColors.primaryWhite),
              decoration: InputDecoration(
                hintText: "Being Yute",
                hintStyle: TextStyle(color: AppColors.primaryWhite),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryWhite),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryWhite),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppText.cancel,
                    style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.w300, color: AppColors.primaryWhite),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppText.rename,
                    style: AppTextStyles.heading3
                        .copyWith(fontWeight: FontWeight.w300, color: AppColors.mainColor.withOpacity(0.9)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
