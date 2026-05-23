import 'package:dzikirapp/app/data/functions/date_helper.dart';
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
              final dateStr = dzikir.createdAt != null 
                  ? DateHelper.formatFullDate(dzikir.createdAt!) 
                  : '';

              return ListTile(
                title: Text(dzikir.ucapan, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Target: ${dzikir.target}"),
                    Text(dateStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
