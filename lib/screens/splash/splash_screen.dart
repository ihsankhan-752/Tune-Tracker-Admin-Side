import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_admin_panel/screens/auth/login_screen.dart';
import 'package:flick_admin_panel/screens/custom_nav_bar/custom_nav_bar.dart';
import 'package:flick_admin_panel/utils/navigation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser != null) {
        navigateToPage(context, const CustomNavBar());
      } else {
        navigateToPage(context, const LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 300,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
