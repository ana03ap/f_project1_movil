import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../pages/startpage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final RxString name = ''.obs;  // 🔥 Variable reactiva

  void navigateToStartPage() {
    if (nameController.text.isNotEmpty) {
      name.value = nameController.text;  // Actualiza la variable reactiva
      Get.snackbar(
        'Hello', 
        'Welcome ${name.value}!',
        snackPosition: SnackPosition.BOTTOM,
      );

      // 🔥 Navegación a StartPage usando GetX
      Get.to(() => const Placeholder());
    } else {
      Get.snackbar(
        'Error',
        'Please enter your name.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
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
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input Name',
              ),
              onChanged: (value) => name.value = value, // 🔥 Hace que la variable sea reactiva
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: navigateToStartPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Start', style: AppStyles.button),
            ),
          ],
        ),
      ),
    );
  }
}
