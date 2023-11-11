import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_admin_panel/model/program_schedule_model.dart';
import 'package:flick_admin_panel/screens/custom_nav_bar/scedule_screen/widgets/program_schedule_card.dart';
import 'package:flick_admin_panel/screens/custom_nav_bar/upload_screen/upload_program_schedule.dart';
import 'package:flick_admin_panel/theme/app_text.dart';
import 'package:flick_admin_panel/theme/colors.dart';
import 'package:flick_admin_panel/theme/text_style.dart';
import 'package:flick_admin_panel/utils/navigation.dart';
import 'package:flick_admin_panel/widget/primary_button.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Center(
                child: Text(
              AppText.programmeSchedule,
              style: AppTextStyles.heading1
                  .copyWith(color: AppColors.mainColor.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 18),
            )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('programSchedule')
                          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                const Text("You Did Not Upload Show!"),
                                PrimaryButton(
                                  onTap: () {
                                    navigateToPage(context, const UploadProgramScheduleScreen());
                                  },
                                  title: "Upload",
                                )
                              ],
                            ),
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProgramScheduleModel programSchedule =
                                ProgramScheduleModel.fromDoc(snapshot.data!.docs[index]);

                            return ProgramScheduleCard(programSchedule: programSchedule);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: AppColors.primaryGrey,
                              thickness: 1,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
