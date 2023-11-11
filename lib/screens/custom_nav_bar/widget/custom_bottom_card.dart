import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class CustomBottomCard extends StatefulWidget {
  // final Color? color;
  final IconData? icon;
  final String? title;
  final int? index;
  final VoidCallback? onPressed;
  int? selectedIndex;

  CustomBottomCard({Key? key, this.icon, this.title, this.index, this.selectedIndex, this.onPressed}) : super(key: key);

  @override
  State<CustomBottomCard> createState() => _CustomBottomCardState();
}

class _CustomBottomCardState extends State<CustomBottomCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryBlack),
          color: widget.selectedIndex == widget.index ? AppColors.primaryBlack : AppColors.mainColor.withOpacity(0.9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: widget.selectedIndex == widget.index ? AppColors.primaryWhite : AppColors.primaryBlack),
            Text(
              widget.title!,
              style: TextStyle(
                color: widget.selectedIndex == widget.index ? AppColors.primaryWhite : AppColors.primaryBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
