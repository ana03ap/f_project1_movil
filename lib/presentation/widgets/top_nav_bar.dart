import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/top_nav_controller.dart';

class TopNavBar extends StatelessWidget {
  final TopNavController topNavController = Get.put(TopNavController());

  TopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            _buildFlexibleTab('Upcoming Events', 0),
            _buildFlexibleTab('Past Events', 1),
          ],
        ));
  }

  Widget _buildFlexibleTab(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => topNavController.onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: topNavController.currentIndex.value == index
                    ? Colors.purple
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: topNavController.currentIndex.value == index
                  ? Colors.purple
                  : Colors.grey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}