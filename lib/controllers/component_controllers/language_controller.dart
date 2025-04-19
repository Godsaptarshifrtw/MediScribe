import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  var selectedLanguage = ''.obs;

  void selectLanguage(String code) {
    selectedLanguage.value = code;
    Get.updateLocale(Locale(code)); // 👈 important: change locale
  }

  void proceed() {
    if (selectedLanguage.isNotEmpty) {
      Get.toNamed('/onboarding'); // or Get.offNamed if you don't want back
    }
  }
}
