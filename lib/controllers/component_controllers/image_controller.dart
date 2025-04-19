import 'dart:io';
import 'package:get/get.dart';

class ImageController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);

  void pickImage(File file) {
    selectedImage.value = file;
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
