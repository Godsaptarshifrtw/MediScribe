import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  PageController pageController = PageController();
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "আপনার মেডিকেল রিপোর্ট বুঝুন",
      "description": "MediScribe জটিল মেডিকেল টার্ম সহজ ভাষায় ব্যাখ্যা করে।",
      "image": "assets/1st.png"
    },
    {
      "title": "সহজেই আপলোড বা স্ক্যান করুন",
      "description": "একটি ছবি তুলুন বা রিপোর্ট আপলোড করুন – আমরা বাকিটা দেখবো।",
      "image": "assets/2nd.png"
    },
    {
      "title": "তাত্ক্ষণিক AI বিশ্লেষণ",
      "description": "হাইলাইট, অনুবাদিত রেজাল্ট এবং বুদ্ধিমান প্রশ্নাবলি পান।",
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
