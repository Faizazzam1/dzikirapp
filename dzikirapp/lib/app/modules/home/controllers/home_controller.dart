import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  final hari = [
    {"hari": "Senin", "tanggal": "1"},
    {"hari": "Selasa", "tanggal": "2"},
    {"hari": "Rabu", "tanggal": "3"},
    {"hari": "Kamis", "tanggal": "4"},
    {"hari": "Jumat", "tanggal": "5"},
    {"hari": "Sabtu", "tanggal": "6"},
    {"hari": "Minggu", "tanggal": "7"},
  ];

  final dataDzikir = [
    {'title': 'Alhamdulillah', 'isComplete': true},
    {'title': 'Astaghfirullah', 'isComplete': true},
    {'title': 'Alhamdulillah', 'isComplete': false},
    {'title': 'Alhamdulillah', 'isComplete': false},
    {'title': 'Alhamdulillah', 'isComplete': false},
    {'title': 'Alhamdulillah', 'isComplete': false},
    {'title': 'Alhamdulillah', 'isComplete': false},
    {'title': 'Alhamdulillah', 'isComplete': false},
    {'title': 'Alhamdulillah', 'isComplete': false},
    {'title': 'Alhamdulillah', 'isComplete': false},
  ].obs;

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
