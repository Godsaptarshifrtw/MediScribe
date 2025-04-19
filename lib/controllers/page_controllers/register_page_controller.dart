import 'package:get/get.dart';
class RegisterController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var age = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  void register() {
    // Do registration logic here
    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      // Navigate to home or show success message
    });
  }
}
