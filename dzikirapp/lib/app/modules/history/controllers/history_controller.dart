import 'package:dzikirapp/app/core/utils/snackbar_handler.dart';
import 'package:dzikirapp/app/data/services/dzikir_services.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final services = DzikirServices();

  final isLoading = false.obs;
  final dzikirList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getHistoryDzikir();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getHistoryDzikir() async {
    isLoading.value = true;
    try {
      final response = await services.getHistoryDzikir();
      dzikirList.value = response;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      SnackbarHandler.showError('Gagal Memuat Riwayat', e.toString());
      print('DZIKIR SERVICE ERROR: $e');
    }
  }
}
