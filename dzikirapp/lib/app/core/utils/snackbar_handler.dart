import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHandler {
  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: const Color(0xFF188359),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }

  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      duration: const Duration(seconds: 4),
    );
  }

  static void showWarning(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.orangeAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }
}
