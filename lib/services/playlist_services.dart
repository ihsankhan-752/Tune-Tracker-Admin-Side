// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/widget/custom_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PlayListServices {
  uploadSpotifyLink({required BuildContext context, required String spotifyLink, required String description}) async {
    if (spotifyLink.isEmpty) {
      showCustomMsg(context, 'Spotify Link Required');
    } else if (description.isEmpty) {
      showCustomMsg(context, 'Description Required');
    } else {
      try {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
        await FirebaseFirestore.instance.collection('spotify').doc(FirebaseAuth.instance.currentUser!.uid).set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'spotifyLink': spotifyLink,
          'description': description,
        });
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, 'Shopify Link Uploaded Successfully');
      } on FirebaseException catch (e) {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, e.message!);
      }
    }
  }

  uploadYoutubeLink({required BuildContext context, required String youtubeLink, required String description}) async {
    if (youtubeLink.isEmpty) {
      showCustomMsg(context, 'Youtube Link Required');
    } else if (description.isEmpty) {
      showCustomMsg(context, 'Description Required');
    } else {
      try {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
        await FirebaseFirestore.instance.collection('youtube').doc(FirebaseAuth.instance.currentUser!.uid).set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'youtube': youtubeLink,
          'description': description,
        });
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, 'Youtube Link Uploaded Successfully');
      } on FirebaseException catch (e) {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, e.message!);
      }
    }
  }
}
