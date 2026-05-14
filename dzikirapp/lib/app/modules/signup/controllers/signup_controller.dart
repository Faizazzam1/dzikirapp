import 'package:dzikirapp/app/data/services/auth_services.dart';
import 'package:dzikirapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final services = AuthServices();

  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  RxBool isloading = false.obs;
  RxBool isVisible = true.obs;
  //TODO: Implement SignupController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void passVisibility() {
    isVisible.value = !isVisible.value;
  }

  Future<void> signUp() async {
    isloading.value = true;
    try {
      final response = await services.signUp(passwordC.text, emailC.text);
      if (response) {
        isloading.value = false;
        Get.offNamed(Routes.HOME);
      }
    } catch (e) {
      isloading.value = false;
      print('AUTH CONTROLLER ERROR: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
