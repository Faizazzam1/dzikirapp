import 'package:dzikirapp/app/core/utils/snackbar_handler.dart';
import 'package:dzikirapp/app/data/models/dzikir_model.dart';
import 'package:dzikirapp/app/data/services/dzikir_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dzikirapp/app/routes/app_pages.dart';

class CounterController extends GetxController {
  late DzikirModel args;
  final services = DzikirServices();

  final RxInt jumlah = 0.obs;
  final RxDouble percentage = 0.0.obs;

  bool isFinished = false;
  DateTime? lastClickTime;
  DateTime? lastWarningTime;

  @override
  void onInit() {
    if (Get.arguments == null) {
      args = DzikirModel(ucapan: '', target: 1, jumlah: 0);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.HOME);
      });
      super.onInit();
      return;
    }

    args = Get.arguments as DzikirModel;
    jumlah.value = args.jumlah;
    percentage.value = (jumlah.value / args.target) * 100;
    
    if (jumlah.value >= args.target) {
      isFinished = true;
    }
    
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

  Future<void> counter() async {
    if (isFinished) return;
    if (args.id == null) return;

    final now = DateTime.now();
    if (lastClickTime != null) {
      final diff = now.difference(lastClickTime!);
      if (diff.inMilliseconds < 180) { // Throttle spam clicks
        if (lastWarningTime == null || now.difference(lastWarningTime!).inSeconds >= 2) {
          SnackbarHandler.showError('Peringatan', 'Dzikir yang khusyuk');
          lastWarningTime = now;
        }
        return; 
      }
    }
    lastClickTime = now;

    jumlah.value++;
    percentage.value = (jumlah.value / args.target) * 100;

    if (jumlah.value >= args.target) {
      isFinished = true;
      SnackbarHandler.showSuccess('Selesai', 'Alhamdulillah, target dzikir tercapai!');
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    }

    try {
      // Tidak di-await agar UI sangat responsif
      services.updateJumlah(args.id!, jumlah.value);
      print('JUMLAH: ${jumlah.value}\nPERCENTAGE: ${percentage.value}');
    } catch (e) {
      SnackbarHandler.showError('Gagal Memperbarui', e.toString());
      print('UPDATE DZIKIR CONTROLLER ERROR: $e');
    }
  }

  Future<void> updateDzikir() async {
    if (args.id == null) return;
    try {
      final data = DzikirModel(
        id: args.id,
        ucapan: args.ucapan,
        target: args.target,
        jumlah: jumlah.value,
        createdAt: args.createdAt,
        userId: args.userId,
      );
      await services.updateDzikir(data);
      print('UPDATE DZIKIR CONTROLLER SUCCESS');
    } catch (e) {
      SnackbarHandler.showError('Gagal Menyimpan Progress', e.toString());
      print('DZIKIR CONTROLLER ERROR: $e');
    }
  }
}
