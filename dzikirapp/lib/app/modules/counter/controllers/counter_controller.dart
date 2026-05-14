import 'package:dzikirapp/app/data/models/dzikir_model.dart';
import 'package:dzikirapp/app/data/services/dzikir_services.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  DzikirModel args = Get.arguments;
  final services = DzikirServices();

  final RxInt jumlah = 0.obs;
  final RxDouble percentage = 0.0.obs;

  @override
  void onInit() {
    percentage.value = jumlah.value / args.target * 100;
    jumlah.value = args.jumlah;
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
    jumlah.value++;

    percentage.value = jumlah.value / args.target;

    await services.updateJumlah(args.id!, jumlah.value);
  }

  Future<void> updateDzikir() async {
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
      print('DZIKIR CONTROLLER ERROR: $e');
    }
  }
}
