import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  var selectedLanguage = ''.obs;
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Load language preference from GetStorage on initialization
    selectedLanguage.value = _storage.read('language') ?? 'en';
    // Set the initial locale if it's not null or empty
    Get.updateLocale(Locale(selectedLanguage.value));
  }

  /// Selects language and updates the app locale
  void selectLanguage(String code) {
    selectedLanguage.value = code;
    _storage.write('language', code); // Save to GetStorage
    Get.updateLocale(Locale(code));
  }

  /// Checks if current language is Bengali
  bool get isBengali => selectedLanguage.value == 'bn';

  /// Proceed to next screen, defaults to English if none selected
  void proceed() {
    if (selectedLanguage.isEmpty) {
      selectedLanguage.value = 'en';
      _storage.write('language', 'en'); // Save default language
      Get.updateLocale(const Locale('en'));
    }
    Get.toNamed('/onboarding');
  }
}
