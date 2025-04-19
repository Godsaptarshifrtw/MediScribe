import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'app_name': 'MediScribe',
      'choose_language': 'Choose Your Language',
      'continue': 'Continue',
      'onboarding_welcome': 'Welcome to MediScribe',
      // Add more keys as needed
    },
    'bn': {
      'app_name': 'মেডিস্ক্রাইব',
      'choose_language': 'আপনার ভাষা নির্বাচন করুন',
      'continue': 'চালিয়ে যান',
      'onboarding_welcome': 'মেডিস্ক্রাইবে স্বাগতম',
      // Add more keys as needed
    },
  };
}
