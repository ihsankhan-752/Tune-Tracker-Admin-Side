import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_admin_panel/model/magazine_model.dart';
import 'package:flick_admin_panel/screens/custom_nav_bar/our_magazine/widgets/magazine_card.dart';
import 'package:flick_admin_panel/screens/custom_nav_bar/upload_screen/upload_magazine_screen.dart';
import 'package:flick_admin_panel/theme/app_text.dart';
import 'package:flick_admin_panel/utils/navigation.dart';
import 'package:flick_admin_panel/widget/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../theme/text_style.dart';

class OurMagazine extends StatefulWidget {
  const OurMagazine({Key? key}) : super(key: key);

  @override
  State<OurMagazine> createState() => _OurMagazineState();
}

class _OurMagazineState extends State<OurMagazine> {
  final List<String> popupTitle = [AppText.edit, AppText.duplicate, AppText.delete];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Center(
                child: Text(
                  AppText.flickMagazine,
                  style: AppTextStyles.heading1
                      .copyWith(color: AppColors.mainColor.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  navigateToPage(context, const UploadMagazineScreen());
                },
                icon: Icon(Icons.add, color: AppColors.mainColor),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('ourMagazine')
                .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Magazine Uploaded!", style: AppTextStyles.heading1),
                    const SizedBox(height: 10),
                    PrimaryButton(
                      onTap: () {
                        navigateToPage(context, const UploadMagazineScreen());
                      },
                      title: "Upload Magazine",
                    )
                  ],
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  MagazineModel magazineModel = MagazineModel.fromDoc(snapshot.data!.docs[index]);
                  return MagazineCard(magazineModel: magazineModel);
                },
              );
            },
          )),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
