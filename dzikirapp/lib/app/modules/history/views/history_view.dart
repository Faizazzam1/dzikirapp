import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dzikir Sebelumnya'), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.dzikirList.isEmpty) {
          return const Center(child: Text('Belum ada dzikir sebelumnya'));
        }
        return RefreshIndicator(
          onRefresh: () async => controller.getHistoryDzikir(),
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: controller.dzikirList.length,
            itemBuilder: (context, index) {
              final dzikir = controller.dzikirList[index];

              return ListTile(
                title: Text(dzikir.ucapan),
                subtitle: Text(dzikir.target.toString()),
              );
            },
          ),
        );
      }),
    );
  }
}
