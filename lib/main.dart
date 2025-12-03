// Assuming you have 'homescreen.dart' defined

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lessionlab/firebase_options.dart';
import 'package:lessionlab/models/user_model.dart';
import 'package:lessionlab/res/routes/app_routes.dart';
import 'package:lessionlab/view/splash/splash_screen.dart';
import 'package:lessionlab/view_model/theme/app_theme.dart';

UserModel? localUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      getPages: AppRoutes.routes(),
      home: const SplashScreen(),
      // home: const ModelInferencePage1(),
      // home: const ModelInferencePage(),
    );
  }
}
