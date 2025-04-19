import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  void login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty');
      return;
    }

    isLoading.value = true;

    // Simulate login process
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    Get.snackbar('Success', 'Logged in successfully');

    // TODO: Navigate to home screen
  }
}
