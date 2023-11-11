import 'package:flick_admin_panel/model/magazine_model.dart';
import 'package:flick_admin_panel/screens/custom_nav_bar/our_magazine/magazine_details.dart';
import 'package:flick_admin_panel/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../theme/colors.dart';
import '../../../../theme/text_style.dart';

class MagazineCard extends StatelessWidget {
  final MagazineModel magazineModel;
  const MagazineCard({super.key, required this.magazineModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToPage(
          context,
          MagazineDetailsScreen(
            title: magazineModel.title!,
            subtitle: magazineModel.description!,
            image: magazineModel.image!,
            id: magazineModel.docId!,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(magazineModel.image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 05),
          Text(magazineModel.title!, style: AppTextStyles.heading1),
          const SizedBox(height: 5),
          Text(timeago.format(magazineModel.createdAt!), style: AppTextStyles.heading1),
          Divider(thickness: 0.5, color: AppColors.mainColor),
        ],
      ),
    );
  }
}
