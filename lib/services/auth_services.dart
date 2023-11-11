// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_admin_panel/model/user_model.dart';
import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/screens/custom_nav_bar/custom_nav_bar.dart';
import 'package:flick_admin_panel/utils/navigation.dart';
import 'package:flick_admin_panel/widget/custom_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthServices {
  signUp({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    if (username.isEmpty) {
      showCustomMsg(context, "Enter Your Name Please");
    } else if (email.isEmpty) {
      showCustomMsg(context, "Enter Email Address Please");
    } else if (password.isEmpty) {
      showCustomMsg(context, "Enter Password Please");
    } else {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        UserModel userModel = UserModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          username: username,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(userModel.toMap());
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        navigateToPage(context, const CustomNavBar());
      } on FirebaseAuthException catch (err) {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, err.message.toString());
      }
    }
  }

  signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      showCustomMsg(context, "Email Must Be Filled");
    } else if (password.isEmpty) {
      showCustomMsg(context, "Password Must Be Filled");
    } else {
      Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        navigateToPage(context, const CustomNavBar());
      } on FirebaseAuthException catch (err) {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        showCustomMsg(context, err.message.toString());
      }
    }
  }
}
