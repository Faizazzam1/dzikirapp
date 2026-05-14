import 'package:dzikirapp/app/data/functions/date_helper.dart';
import 'package:dzikirapp/app/data/models/dzikir_model.dart';
import 'package:dzikirapp/app/data/services/dzikir_services.dart';
import 'package:dzikirapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  final dateHelper = DateHelper();
  final dzikirServices = DzikirServices();

  final dzikirC = TextEditingController();
  final targetC = TextEditingController();

  final todayHeader = ''.obs;
  final dataDzikir = <DzikirModel>[].obs;
  final pastDzikir = <DzikirModel>[].obs;
  final selectedDzikir = <DzikirModel>[].obs;
  final isLoading = false.obs;
  final RxList<Map<String, dynamic>> next7Days = <Map<String, dynamic>>[].obs;
  final selectedDate = DateTime.now().obs;
  late RealtimeChannel dzikirChannel;

  bool isSelectedDate(DateTime date) {
    final selected = selectedDate.value;

    return selected.year == date.year &&
        selected.month == date.month &&
        selected.day == date.day;
  }

  //TODO: Implement HomeController

  @override
  void onInit() async {
    todayHeader.value = dateHelper.getTodayDateAndMonth();
    next7Days.value = dateHelper.getNext7Days();
    await getDzikir();
    selectDzikir(DateTime.now());
    initRealtimeDzikir();
    super.onInit();
  }

  void initRealtimeDzikir() {
    dzikirChannel = Supabase.instance.client
        .channel('dzikir-realtime')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'dzikir',
          table: 'dzikir',
          callback: (payload) async {
            print('REALTIME DZIKIR: $payload');

            await getDzikir();
          },
        )
        .subscribe();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    dzikirChannel.unsubscribe();

    super.onClose();
  }

  Future<void> addDzikir() async {
    isLoading.value = true;
    try {
      await dzikirServices.addDzikir(dzikirC.text, int.parse(targetC.text));
      isLoading.value = false;
      Get.back();
      Get.toNamed(
        Routes.COUNTER,
        arguments: DzikirModel(
          ucapan: dzikirC.text,
          target: int.parse(targetC.text),
          jumlah: 0,
        ),
      );
    } catch (e) {
      isLoading.value = false;
      print('DZIKIR SERVICE ERROR: $e');
    }
  }

  Future<void> getDzikir() async {
    isLoading.value = true;
    try {
      final response = await dzikirServices.getDzikir();

      dataDzikir.value = response;

      pastDzikir.value = response.where((item) {
        final date = item.createdAt!;
        final itemDate = DateTime(date.year, date.month, date.day);
        final now = DateTime.now();
        final todayDate = DateTime(now.year, now.month, now.day);
        return itemDate.isBefore(todayDate);
      }).toList();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('DZIKIR SERVICE ERROR: $e');
    }
  }

  void selectDzikir(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);

    selectedDzikir.value = dataDzikir.where((item) {
      final createdAt = item.createdAt!;

      return createdAt.year == date.year &&
          createdAt.month == date.month &&
          createdAt.day == date.day;
    }).toList();
  }
}
