import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_admin_panel/model/show_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../theme/app_text.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text_style.dart';
import '../../../../utils/navigation.dart';
import '../../../../widget/custom_popup_button.dart';
import '../../upload_screen/upload_show_screen.dart';

class OurShowCard extends StatelessWidget {
  final ShowModel showModel;
  const OurShowCard({super.key, required this.showModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 15),
      leading: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(showModel.image),
          ),
        ),
      ),
      title: Text(
        showModel.title,
        style: AppTextStyles.heading1,
      ),
      subtitle: Text(showModel.timeAndDate,
          style: AppTextStyles.heading3.copyWith(
            fontSize: 12,
          )),
      trailing: CustomPopupButton(
        onSelected: (v) async {
          var docId = const Uuid().v4();
          if (v == AppText.upload) {
            navigateToPage(context, const UploadShowScreen());
          }
          if (v == AppText.duplicate) {
            ShowModel shModel = ShowModel(
                userId: FirebaseAuth.instance.currentUser!.uid,
                description: showModel.description,
                timeAndDate: showModel.timeAndDate,
                image: showModel.image,
                title: showModel.title,
                showLocation: showModel.showLocation,
                docId: docId);
            await FirebaseFirestore.instance.collection('ourShow').doc(docId).set(shModel.toMap());
          }
          if (v == AppText.delete) {
            await FirebaseFirestore.instance.collection('ourShow').doc(showModel.docId).delete();
          }
        },
        item: [
          PopupMenuItem(
            value: AppText.upload,
            child: Text(
              AppText.upload,
              style: TextStyle(color: AppColors.primaryWhite),
            ),
          ),
          const PopupMenuDivider(height: 5),
          PopupMenuItem(
            value: AppText.duplicate,
            child: Text(
              AppText.duplicate,
              style: TextStyle(color: AppColors.primaryWhite),
            ),
          ),
          const PopupMenuDivider(height: 5),
          PopupMenuItem(
            value: AppText.delete,
            child: Text(
              AppText.delete,
              style: TextStyle(color: AppColors.primaryWhite),
            ),
          ),
        ],
      ),
    );
  }
}
