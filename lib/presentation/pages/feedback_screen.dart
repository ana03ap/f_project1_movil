import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../widgets/bottom_nav_bar.dart';

class FeedbackScreen extends StatelessWidget {
  final TextEditingController feedbackController = TextEditingController();
  final RxInt selectedRating = 0.obs;
  final BottomNavController bottomNavController = Get.find();

  FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TuBoleta'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Leave a feedback!',
              style: AppStyles.title,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write a feedback...',
                border: InputBorder.none,
                filled: true,
                fillColor: const Color.fromRGBO(240, 240, 240, 1),
                contentPadding: const EdgeInsets.all(16),
                hintStyle: TextStyle(color: Colors.grey[600]),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 123, 56, 186), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Rate your experience:',
              style: AppStyles.subtitle,
            ),
            const SizedBox(height: 10),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      5,
                      (index) => IconButton(
                            onPressed: () {
                              selectedRating.value = index + 1;
                            },
                            icon: Icon(
                              Icons.star,
                              color: index < selectedRating.value
                                  ? Colors.purple
                                  : Colors.grey,
                              size: 32,
                            ),
                          )),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (feedbackController.text.isNotEmpty &&
                    selectedRating.value > 0) {
                  Get.snackbar(
                    'Feedback Sent!',
                    'Thank you for your feedback!',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  feedbackController.clear();
                  selectedRating.value = 0;
                } else {
                  Get.snackbar(
                    'Error',
                    'Please write feedback and select a rating.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Submit', style: AppStyles.button),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
