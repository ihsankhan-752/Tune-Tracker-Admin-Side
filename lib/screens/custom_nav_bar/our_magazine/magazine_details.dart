import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_admin_panel/theme/colors.dart';
import 'package:flick_admin_panel/theme/text_style.dart';
import 'package:flick_admin_panel/utils/constant.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_text.dart';

class MagazineDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String id;

  const MagazineDetailsScreen(
      {Key? key, required this.title, required this.subtitle, required this.image, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: InkWell(
        onTap: () async {
          await FirebaseFirestore.instance.collection('ourMagazine').doc(id).delete();
          Navigator.pop(context);
        },
        child: Container(
          height: 60,
          width: double.infinity,
          color: Colors.red,
          child: Center(
            child: Text(AppText.delete, style: AppTextStyles.heading1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getHeight(context, 0.32),
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      image,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.primaryWhite,
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // title
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: AppTextStyles.heading1.copyWith(
                              fontSize: 30,
                              color: AppColors.mainColor.withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // subtitle
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            subtitle,
                            style: AppTextStyles.heading2
                                .copyWith(color: AppColors.primaryWhite, fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
