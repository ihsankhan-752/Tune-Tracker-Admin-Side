import 'package:flick_admin_panel/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomPopupButton extends StatelessWidget {
  final Color color;
  final Function(dynamic v)? onSelected;
  final List<PopupMenuEntry> item;

  const CustomPopupButton({
    super.key,
    required this.item,
    this.onSelected,
    this.color = const Color(0xff1A1A1A),
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: AppColors.primaryWhite),
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        onSelected: onSelected,
        color: AppColors.lightBlackColor,
        icon: Icon(
          Icons.more_vert,
          color: AppColors.primaryWhite,
        ),
        itemBuilder: (BuildContext context) {
          return item;
        },
      ),
    );
  }
}
