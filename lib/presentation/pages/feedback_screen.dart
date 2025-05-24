// import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
// import 'package:f_project_1/presentation/controllers/event_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_styles.dart';
// import '../widgets/bottom_nav_bar.dart';

// class FeedbackScreen extends StatelessWidget {
//   final TextEditingController feedbackController = TextEditingController();
//   final RxInt selectedRating = 0.obs;
//   final BottomNavController bottomNavController = Get.find();

//   FeedbackScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PuntoG'),
//         centerTitle: true,
//         backgroundColor: theme.scaffoldBackgroundColor,
//         elevation: 0,
//         foregroundColor: theme.textTheme.titleLarge?.color,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),
//             Text('Leave a feedback!', style: theme.textTheme.headlineSmall),
//             const SizedBox(height: 20),
//             TextField(
//               key: const Key('feedbackField'), // Key para pruebas
//               controller: feedbackController,
//               maxLines: 5,
//               decoration: InputDecoration(
//                 hintText: 'Write a feedback...',
//                 border: InputBorder.none,
//                 filled: true,
//                 fillColor: isDark ? Colors.grey[850] : const Color(0xFFF7F7F7),
//                 contentPadding: const EdgeInsets.all(16),
//                 hintStyle: TextStyle(
//                     color: isDark ? Colors.grey[400] : const Color(0xFF959595)),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(
//                     color: Color.fromARGB(255, 123, 56, 186),
//                     width: 2,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: isDark ? Colors.grey[700]! : const Color(0xFFFAFAFA),
//                     width: 1,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text('Rate your experience:', style: theme.textTheme.titleMedium),
//             const SizedBox(height: 10),
//             Obx(() => Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     5,
//                     (index) => IconButton(
//                       onPressed: () {
//                         selectedRating.value = index + 1;
//                       },
//                       icon: Icon(
//                         Icons.star,
//                         color: index < selectedRating.value
//                             ? AppColors.primary
//                             : Colors.grey,
//                         size: 32,
//                       ),
//                     ),
//                   ),
//                 )),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               key: const Key('submitFeedbackButton'), // Key para pruebas
//               onPressed: () {
//                 if (selectedRating.value > 0) {
//                   final event = Get.find<EventController>().selectedEvent.value;
//                   if (event != null) {
//                     Get.find<EventController>().addFeedback(
//                       event,
//                       selectedRating.value.toDouble(),
//                     );
//                   }
//                 } else {
//                   Get.snackbar(
//                     'Error',
//                     'Por favor selecciona un rating',
//                     snackPosition: SnackPosition.BOTTOM,
//                     backgroundColor: Colors.red,
//                     colorText: Colors.white,
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//               ),
//               child: const Text('Submit', style: AppStyles.button),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(),
//     );
//   }
// }


import 'package:f_project_1/core/constants/app_colors.dart';
import 'package:f_project_1/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/event_controller.dart';
import '../controllers/bottom_nav_controller.dart';

import '../widgets/bottom_nav_bar.dart';

class FeedbackScreen extends StatelessWidget {
  final TextEditingController feedbackController = TextEditingController();
  final RxInt selectedRating = 0.obs;
  final BottomNavController bottomNavController = Get.find();
  final EventController controller = Get.find<EventController>();

  FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    final event = controller.selectedEvent.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('PuntoG'),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: theme.textTheme.titleLarge?.color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text('Leave a feedback!', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 20),
            TextField(
              key: const Key('feedbackField'),
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write a feedback...',
                border: InputBorder.none,
                filled: true,
                fillColor: isDark ? Colors.grey[850] : const Color(0xFFF7F7F7),
                contentPadding: const EdgeInsets.all(16),
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[400] : const Color(0xFF959595),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 123, 56, 186),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.grey[700]! : const Color(0xFFFAFAFA),
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Rate your experience:', style: theme.textTheme.titleMedium),
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
                            ? AppColors.primary
                            : Colors.grey,
                        size: 32,
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('submitFeedbackButton'),
              onPressed: () {
                if (event != null) {
                  if (selectedRating.value > 0) {
                    controller.addFeedback(
                      event,
                      selectedRating.value.toDouble(),
                    );
                    final comment = feedbackController.text.trim();
                    if (comment.isNotEmpty) {
                      controller.addComment(event, comment);
                    }
                  } else {
                    Get.snackbar(
                      'Error',
                      'Por favor selecciona un rating',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
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
