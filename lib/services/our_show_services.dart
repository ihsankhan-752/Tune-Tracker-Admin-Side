// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/services/storage_services.dart';
import 'package:flick_admin_panel/widget/custom_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../model/show_model.dart';

class OurShowServices {
  uploadShowInformation(
      {required BuildContext context,
      required String title,
      required String description,
      required String showLocation,
      required File image,
      required String timeAndDate}) async {
    if (title.isEmpty || description.isEmpty || timeAndDate.isEmpty) {
      showCustomMsg(context, 'All Fields are Required');
    } else {
      try {
        var docId = const Uuid().v4();
        Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
        String imageUrl = await StorageServices().uploadImageToDb(image);

        ShowModel showModel = ShowModel(
          userId: FirebaseAuth.instance.currentUser!.uid,
          description: description,
          timeAndDate: timeAndDate,
          image: imageUrl,
          title: title,
          showLocation: showLocation,
          docId: docId,
        );
        await FirebaseFirestore.instance.collection('ourShow').doc(docId).set(showModel.toMap());
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        Navigator.pop(context);
      } on FirebaseException catch (e) {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, e.message!);
      }
    }
  }
}
