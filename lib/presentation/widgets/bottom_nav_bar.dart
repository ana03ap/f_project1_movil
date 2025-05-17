import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavController bottomNavController = Get.find<BottomNavController>();

  BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = bottomNavController.getCurrentIndex();

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => bottomNavController.onTap(index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.event, key: Key('eventsTab')),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list, key: Key('myEventsTab')), 
          label: 'My Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, key: Key('profileTab')), 
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    );
  }
}
