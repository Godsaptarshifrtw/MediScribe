import 'dart:io';
import 'package:get/get.dart';

class PdfController extends GetxController {
  Rx<File?> selectedPdf = Rx<File?>(null);

  void pickPdf(File file) {
    selectedPdf.value = file;
  }
}