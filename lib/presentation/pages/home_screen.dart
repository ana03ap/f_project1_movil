import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.find<HomeController>();
  final TextEditingController nameController = TextEditingController(
    text: Get.find<HomeController>().name.value,
  );

  void navigateToStartPage() {
    final enteredName = nameController.text.trim();
    if (enteredName.isNotEmpty) {
      homeController
          .setName(enteredName); // Guarda en controlador y SharedPrefs
      Get.toNamed('/startpage');
    } else {
      Get.snackbar(
        'Error',
        'Please enter your name.',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Your Name',
              style: AppStyles.title,
            ),
            const SizedBox(height: 20),
            TextField(
              key: const Key('name_input'),
              controller: nameController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('start_button'),
              onPressed: navigateToStartPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                elevation: 4,
                shadowColor: AppColors.black,
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
