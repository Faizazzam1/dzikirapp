import 'package:dzikirapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Obx(() {
        return Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
                    const SizedBox(height: 28),

                    // Profile Image
                    Center(
                      child: Image.asset(
                        'assets/dzikir_app_icon.png',
                        height: 100,
                        width: 100,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Title
                    const Center(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5D6B63),
                        ),
                      ),
                    ),

                    const SizedBox(height: 42),

                    // Email Label
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF6C6C6C),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Email Field
                    TextField(
                      controller: controller.emailC,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: const TextStyle(color: Color(0xFF9AA69F)),
                        filled: true,
                        fillColor: const Color(0xFFE2F0E7),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 26),

                    // Password Label
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF6C6C6C),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Password Field
                    Obx(() {
                      return TextField(
                        controller: controller.passwordC,
                        obscureText: controller.isVisible.value,
                        decoration: InputDecoration(
                          hintText: 'Create a password',
                          hintStyle: const TextStyle(color: Color(0xFF9AA69F)),
                          filled: true,
                          fillColor: const Color(0xFFE2F0E7),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => controller.passVisibility(),
                            icon: Icon(
                              controller.isVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            color: Color(0xFFB0B8B3),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      );
                    }),

                    const SizedBox(height: 40),

                    // Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.signUp();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF002F22),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Bottom Text
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF8D8D8D),
                            ),
                          ),
                          InkWell(
                            onTap: () => Get.offNamed(Routes.LOGIN),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFC6A76B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // child: RichText(
                      //   text: const TextSpan(
                      //     style: TextStyle(
                      //       fontSize: 15,
                      //       color: Color(0xFF8D8D8D),
                      //     ),
                      //     children: [
                      //       TextSpan(text: 'Don\'t have an account? '),
                      //       TextSpan(
                      //         text: 'Sign Up',
                      //         style: TextStyle(
                      //           color: Color(0xFFC6A76B),
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),

                    const SizedBox(height: 50),

                    // Bottom Decoration
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 28,
                            height: 1.5,
                            color: const Color(0xFFE7DDD2),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.spa_outlined,
                            size: 14,
                            color: Color(0xFFE7DDD2),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 28,
                            height: 1.5,
                            color: const Color(0xFFE7DDD2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (controller.isloading.value)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      }),
    );
  }
}
