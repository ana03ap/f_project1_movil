import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/top_nav_controller.dart';

class TopNavBar extends StatelessWidget {
  final TopNavController topNavController = Get.put(TopNavController());

  TopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
          children: [
            _buildTab('Upcoming Events', 0),
            _buildTab('Past Events', 1),
          ],
        ));
  }

  Widget _buildTab(String label, int index) {
    return GestureDetector(
      onTap: () => topNavController.onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: topNavController.currentIndex.value == index
                ? Colors.purple
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
