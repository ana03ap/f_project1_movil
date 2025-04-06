import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final RxString name = ''.obs;

  void navigateToStartPage() {
    if (nameController.text.isNotEmpty) {
      name.value = nameController.text;

      Get.toNamed('/startpage', arguments: name.value);
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
              onChanged: (value) => name.value = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: navigateToStartPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 167, 91, 248),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                elevation: 4,
                shadowColor: Colors.black,
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
