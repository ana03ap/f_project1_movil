import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../widgets/bottom_nav_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController feedbackController = TextEditingController();
  final RxInt selectedRating = 0.obs;  // Variable reactiva para manejar las estrellas seleccionadas
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        Get.toNamed('/events');
      } else if (index == 1) {
        Get.toNamed('/my_events');
      } else if (index == 2) {
        Get.toNamed('/profile');
      }
    });
  }

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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Rate your experience:',
              style: AppStyles.subtitle,
            ),
            const SizedBox(height: 10),
            
            // 🔥 RATING STARS
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => IconButton(
                onPressed: () {
                  selectedRating.value = index + 1;
                },
                icon: Icon(
                  Icons.star,
                  color: index < selectedRating.value ? Colors.purple : Colors.grey,
                  size: 32,
                ),
              )),
            )),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (feedbackController.text.isNotEmpty && selectedRating.value > 0) {
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
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Submit', style: AppStyles.button),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(  
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
