import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/counter_controller.dart';

class CounterView extends GetView<CounterController> {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: SingleChildScrollView(
              child: Column(
                children: [
                  // TOP AREA
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),

                    decoration: const BoxDecoration(
                      color: Color(0xFF188359),

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            GestureDetector(
                              onTap: () async {
                                await controller.updateDzikir();
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Text(
                          controller.args.ucapan,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "Tenangkan hati dan pikiran",
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),

                        const SizedBox(height: 30),

                        Image.network(
                          "https://cdn-icons-png.flaticon.com/512/4721/4721318.png",
                          height: 160,
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  Obx(
                    () => Text(
                      "Progress Dzikir: ${controller.percentage.toInt()}%",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // CIRCLE
                  Obx(() {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 220,
                          height: 220,

                          child: CircularProgressIndicator(
                            value: controller.percentage.value.toDouble() / 100,
                            strokeWidth: 8,
                            backgroundColor: Colors.grey.shade300,

                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF188359),
                            ),
                          ),
                        ),

                        // POWER BUTTON
                        GestureDetector(
                          onTap: () => controller.counter(),
                          child: Container(
                            width: 95,
                            height: 95,

                            decoration: BoxDecoration(
                              color: const Color(0xFF188359),
                              shape: BoxShape.circle,

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),

                            child: const Icon(
                              Icons.touch_app,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 50),

                  // BOTTOM BUTTON
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        Container(
                          width: 14,
                          height: 14,

                          decoration: const BoxDecoration(
                            color: Color(0xFF188359),
                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          'Dzikir',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
