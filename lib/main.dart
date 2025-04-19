import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'translation/app_translations.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/onboarding_screeen.dart';
import 'screens/language selection_screen.dart';

// Controllers
import 'controllers/component_controllers/pdf_controller.dart';
import 'controllers/component_controllers/image_controller.dart';
import 'controllers/component_controllers/language_controller.dart';
import 'controllers/page_controllers/login_page_controller.dart';
import 'controllers/page_controllers/register_page_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register global controllers
  Get.put(PdfController());
  Get.put(ImageController());
  Get.put(LanguageController());
  Get.put(LoginController());
  Get.put(RegisterController());

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
        translations: AppTranslations(),                     // 🌐 i18n map
        locale: langController.selectedLanguage.isNotEmpty
            ? Locale(langController.selectedLanguage.value)  // dynamically set
            : const Locale('en'),                             // fallback
        fallbackLocale: const Locale('en'),
        initialRoute: '/language',                            // 🔑 Initial screen
        getPages: [
          GetPage(name: '/language', page: () => LanguageScreen()),
          GetPage(name: '/onboarding', page: () => OnboardingScreen()),
          GetPage(name: '/home', page: () => HomeScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/register', page: () => RegisterScreen()),
        ],
      );
      });
    }
}