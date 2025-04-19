import 'package:aignite2025_oops/controllers/component_controllers/image_controller.dart';
import 'package:aignite2025_oops/screens/home_screen.dart';
import 'package:aignite2025_oops/screens/onboarding_screeen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/component_controllers/pdf_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(PdfController());
  Get.put(ImageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/home', // ✅ Launch with onboarding screen
      getPages: [
        GetPage(name: '/onboarding', page: () =>  OnboardingScreen()),
        GetPage(name: '/home', page: () =>  HomeScreen()),

      ],
    );
  }
}
