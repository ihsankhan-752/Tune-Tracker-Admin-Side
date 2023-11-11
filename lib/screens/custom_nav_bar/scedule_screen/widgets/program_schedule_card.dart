import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_admin_panel/model/program_schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../theme/app_text.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text_style.dart';
import '../../../../utils/navigation.dart';
import '../../../../widget/custom_popup_button.dart';
import '../../upload_screen/upload_program_schedule.dart';

class ProgramScheduleCard extends StatelessWidget {
  final ProgramScheduleModel programSchedule;
  const ProgramScheduleCard({super.key, required this.programSchedule});

  @override
  Widget build(BuildContext context) {
    int startTime = programSchedule.startTime;
    int startingHour = startTime ~/ 60;
    int startingMinutes = startTime % 60;

    String formattedStartTime = TimeOfDay(hour: startingHour, minute: startingMinutes).format(context);
    int endTime = programSchedule.endTime;
    int endingHour = endTime ~/ 60;
    int endingMinutes = endTime % 60;

    String formattedEndTime = TimeOfDay(hour: endingHour, minute: endingMinutes).format(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      programSchedule.title,
                      style: AppTextStyles.heading1,
                    ),
                    const Spacer(),
                    Text(
                      programSchedule.selectedDay,
                      style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w300, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 03),
                Text(
                  "$formattedStartTime - $formattedEndTime",
                  style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.w300, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(width: 30),
          CustomPopupButton(
            onSelected: (v) async {
              if (v == "Upload") {
                navigateToPage(context, const UploadProgramScheduleScreen());
              }
              if (v == AppText.delete) {
                await FirebaseFirestore.instance.collection('programSchedule').doc(programSchedule.docId).delete();
              }

              if (v == AppText.duplicate) {
                final docId = const Uuid().v4();
                ProgramScheduleModel programScheduleModel = ProgramScheduleModel(
                  docId: docId,
                  endTime: programSchedule.endTime,
                  startTime: programSchedule.startTime,
                  selectedDay: programSchedule.selectedDay,
                  title: programSchedule.title,
                  uid: programSchedule.uid,
                );
                await FirebaseFirestore.instance
                    .collection('programSchedule')
                    .doc(docId)
                    .set(programScheduleModel.toMap());
              }
            },
            item: [
              PopupMenuItem(
                value: "Upload",
                child: Text(
                  "Upload",
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
        ],
      ),
    );
  }
}
