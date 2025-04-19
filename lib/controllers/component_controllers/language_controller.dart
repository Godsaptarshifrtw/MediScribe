import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectedLanguage = ''.obs;

  void selectLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
  }

  void proceed() {
    if (selectedLanguage.isNotEmpty) {
      Get.toNamed('/onboarding');
    }
  }
}
