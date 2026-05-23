import 'package:dzikirapp/app/core/utils/input_validators.dart';
import 'package:dzikirapp/app/modules/home/views/widgets/list_date.dart';
import 'package:dzikirapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.todayHeader.value,
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF188359),
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 17),
          child: IconButton(
            onPressed: () {
              Get.toNamed(Routes.HISTORY);
            },
            icon: Icon(Icons.access_time, color: Colors.white),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFF188359),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(7)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(color: Colors.white, fontSize: 27),
                      ),
                      Text(
                        "6 Dzikir",
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tambah Dzikir",
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 25),

                                    Text(
                                      "Ucapan Dzikir",
                                      style: TextStyle(fontSize: 14),
                                    ),

                                    SizedBox(height: 8),

                                    TextFormField(
                                      controller: controller.dzikirC,
                                      validator: (value) => InputValidators.validateRequired(value, 'Ucapan Dzikir'),
                                      decoration: InputDecoration(
                                        hintText: "Masukan Dzikir",
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20),

                                    Text(
                                      "Target Dzikir",
                                      style: TextStyle(fontSize: 14),
                                    ),

                                    SizedBox(height: 8),

                                    TextFormField(
                                      controller: controller.targetC,
                                      keyboardType: TextInputType.number,
                                      validator: (value) => InputValidators.validateNumeric(value, 'Target Dzikir'),
                                      decoration: InputDecoration(
                                        hintText: "...",
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 30),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            "Batal",
                                            style: TextStyle(
                                              color: Color(0xFF188359),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 12),

                                        Obx(() {
                                          return ElevatedButton(
                                            onPressed: () {
                                              controller.addDzikir();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xFF188359),
                                              foregroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 28,
                                                vertical: 12,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: controller.isLoading.value
                                                ? CircularProgressIndicator(color: Colors.white)
                                                : Text("Lanjut"),
                                          );
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF188359),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Add New",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ListDate(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Row(
              children: [Text("My Dzikir", style: TextStyle(fontSize: 22))],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.getDzikir(),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.selectedDzikir.isEmpty) {
                  return Center(child: Text("Belum ada dzikir"));
                }
                return ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: controller.selectedDzikir.length,

                  itemBuilder: (context, index) {
                    final dataDzikir = controller.selectedDzikir[index];
                    final isComplete = dataDzikir.jumlah == dataDzikir.target;

                    return GestureDetector(
                      onTap: () async {
                        await Get.toNamed(Routes.COUNTER, arguments: dataDzikir);
                        controller.getDzikir();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 8,
                        ),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                dataDzikir.ucapan.toString(),
                                style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            isComplete
                                ? Checkbox(
                                    value: isComplete,
                                    onChanged: (value) {},
                                    activeColor: Color(0xFF188359),
                                  )
                                : Row(
                                    children: [
                                      Text(dataDzikir.jumlah.toString()),
                                      Text("/"),
                                      Text(dataDzikir.target.toString()),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
