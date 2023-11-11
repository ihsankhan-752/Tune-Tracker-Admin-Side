// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_admin_panel/model/program_schedule_model.dart';
import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/widget/custom_msg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ScheduleServices {
  uploadProgramSchedule({
    required BuildContext context,
    required String selectedDay,
    required String programTitle,
    required int startTime,
    required int endTime,
  }) async {
    if (selectedDay.isEmpty || programTitle.isEmpty || startTime == null || endTime == null) {
      showCustomMsg(context, "All Fields Are Required");
    } else {
      var docId = const Uuid().v1();
      Provider.of<LoadingProvider>(context, listen: false).setLoading(true);

      try {
        ProgramScheduleModel programScheduleModel = ProgramScheduleModel(
          docId: docId,
          endTime: endTime,
          startTime: startTime,
          selectedDay: selectedDay,
          title: programTitle,
          uid: FirebaseAuth.instance.currentUser!.uid,
        );
        await FirebaseFirestore.instance.collection('programSchedule').doc(docId).set(programScheduleModel.toMap());
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, "Program Data is Uploaded Successfully");
        Navigator.pop(context);
      } on FirebaseException catch (err) {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, err.message.toString());
      }
    }
  }
}
