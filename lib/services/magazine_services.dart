// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_admin_panel/model/magazine_model.dart';
import 'package:flick_admin_panel/services/storage_services.dart';
import 'package:flick_admin_panel/widget/custom_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../providers/loading_provider.dart';

class MagazineServices {
  uploadMagazineInformation(
      {required BuildContext context, required File image, required String title, required String description}) async {
    if (image == null) {
      showCustomMsg(context, "Upload Image");
    } else if (title.isEmpty) {
      showCustomMsg(context, "Upload Title");
    } else if (description.isEmpty) {
      showCustomMsg(context, "Upload Description");
    } else {
      try {
        var docId = const Uuid().v4();
        Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
        String imageUrl = await StorageServices().uploadImageToDb(image);
        MagazineModel magazineModel = MagazineModel(
          docId: docId,
          userId: FirebaseAuth.instance.currentUser!.uid,
          createdAt: DateTime.now(),
          image: imageUrl,
          title: title,
          description: description,
        );
        await FirebaseFirestore.instance.collection('ourMagazine').doc(docId).set(magazineModel.toMap());
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        Navigator.pop(context);
      } on FirebaseException catch (e) {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, e.message!);
      }
    }
  }
}
