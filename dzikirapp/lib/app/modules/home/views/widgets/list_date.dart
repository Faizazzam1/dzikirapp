import 'package:dzikirapp/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ListDate extends StatelessWidget {
  const ListDate({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: controller.next7Days.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = controller.next7Days[index];

          final hari = data["dayName"];
          final tanggal = data["dayNumber"];
          final date = data["date"] as DateTime;

          return Obx(() {
            final isSelected = controller.isSelectedDate(date);

            return GestureDetector(
              onTap: () {
                controller.selectDzikir(date);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 70,
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF188359) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hari,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      tanggal.toString(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
