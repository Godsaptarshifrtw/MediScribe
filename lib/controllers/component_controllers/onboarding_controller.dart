import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  PageController pageController = PageController();
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Understand Your Medical Reports",
      "description": "MediScribe simplifies complex medical terms into plain language.",
      "image": "assets/1st.png"
    },
    {
      "title": "Upload or Scan with Ease",
      "description": "Just click a photo or upload your medical report – we'll take care of the rest.",
      "image": "assets/2nd.png"
    },
    {
      "title": "Instant AI-Powered Insights",
      "description": "See highlights, translated results, and get smart doctor questions.",
      "image": "assets/3rd.png"
    },
  ];

  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void skip() {
    currentPage.value = onboardingData.length - 1;
    pageController.jumpToPage(onboardingData.length - 1);
  }
}
