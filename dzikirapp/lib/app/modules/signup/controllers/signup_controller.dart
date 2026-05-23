import 'package:dzikirapp/app/core/utils/snackbar_handler.dart';
import 'package:dzikirapp/app/data/services/auth_services.dart';
import 'package:dzikirapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final services = AuthServices();

  final formKey = GlobalKey<FormState>();
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
    if (!formKey.currentState!.validate()) {
      return;
    }

    isloading.value = true;
    try {
      final response = await services.signUp(passwordC.text, emailC.text);
      if (response) {
        SnackbarHandler.showSuccess('Pendaftaran Berhasil', 'Akun berhasil dibuat');
        Get.offNamed(Routes.HOME);
      } else {
        SnackbarHandler.showError('Pendaftaran Gagal', 'Email sudah terdaftar atau terjadi kesalahan');
      }
    } catch (e) {
      SnackbarHandler.showError('Error', e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
