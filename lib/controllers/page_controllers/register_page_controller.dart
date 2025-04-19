import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../api/auth_api_service.dart';


class RegisterController extends GetxController {
  var name      = ''.obs;
  var email     = ''.obs;
  var age       = ''.obs;
  var phone     = ''.obs;
  var password  = ''.obs;
  var isLoading = false.obs;

  final AuthService _authService = AuthService();

  Future<void> register() async {
    // 1) Basic validation
    if ([name, email, age, phone, password].any((f) => f.value.trim().isEmpty)) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    // 2) Parse age
    int parsedAge;
    try {
      parsedAge = int.parse(age.value.trim());
    } catch (_) {
      Get.snackbar('Error', 'Age must be a number');
      return;
    }

    isLoading.value = true;

    try {
      // 3) Call AuthService
      final user = await _authService.registerWithEmail(
        name: name.value.trim(),
        email: email.value.trim(),
        phone: phone.value.trim(),
        age: parsedAge,
        password: password.value,
      );

      isLoading.value = false;
      Get.snackbar('Registration Successful!','Welcome to MediScribe');
      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar('Registration Failed', e.message ?? e.code);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
