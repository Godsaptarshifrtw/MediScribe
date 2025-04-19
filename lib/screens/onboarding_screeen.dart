import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/component_controllers/onboarding_controller.dart';


class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F0FB),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.onboardingData.length,
                onPageChanged: (index) => controller.currentPage.value = index,
                itemBuilder: (_, index) {
                  var data = controller.onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          data['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          data['description']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Image.asset(
                          data['image']!,
                          height: 250,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.onboardingData.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: controller.currentPage.value == index ? 12 : 8,
                  height: controller.currentPage.value == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.currentPage.value == index
                        ? Colors.deepPurple
                        : Colors.deepPurple.shade100,
                  ),
                ),
              ),
            )),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text("Skip", style: TextStyle(color: Colors.deepPurple)),
                    onPressed: controller.skip,
                  ),
                  controller.currentPage.value == controller.onboardingData.length - 1
                      ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Get Started", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      // Navigate to home or login screen
                    },
                  )
                      : TextButton(
                    child: const Text("Next", style: TextStyle(color: Colors.deepPurple)),
                    onPressed: controller.nextPage,
                  ),
                ],
              )),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
