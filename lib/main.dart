import 'package:firebase_core/firebase_core.dart';
import 'package:flick_admin_panel/providers/image_provider.dart';
import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/providers/pick_start_and_end_time_provider.dart';
import 'package:flick_admin_panel/screens/splash/splash_screen.dart';
import 'package:flick_admin_panel/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => PickStartAndEndTimeProvider()),
        ChangeNotifierProvider(create: (_) => ImageUploadingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.primaryBlack,
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
