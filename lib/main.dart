import 'package:aignite2025_oops/screens/language%20selection_screen.dart';
import 'package:aignite2025_oops/screens/onboarding_screeen.dart';
import 'package:aignite2025_oops/translation/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controllers/component_controllers/image_controller.dart';
import 'controllers/component_controllers/language_controller.dart';
import 'controllers/component_controllers/pdf_controller.dart';
 // ✅ Import your LanguageController
import 'screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register controllers
  Get.put(PdfController());
  Get.put(ImageController());
  Get.put(LanguageController()); // ✅ Register LanguageController

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController langController = Get.find();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MediScribe',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        translations: AppTranslations(), // 🌐 i18n map
        locale: langController.selectedLanguage.isNotEmpty
            ? Locale(langController.selectedLanguage.value)
            : const Locale('en'),
        fallbackLocale: const Locale('en'),
        initialRoute: '/home',
        getPages: [
          GetPage(name: '/language', page: () => LanguageScreen()),
          GetPage(name: '/onboarding', page: () => OnboardingScreen()),
          GetPage(name: '/home', page: () => HomeScreen()),
        ],
      );
    });
  }
}
