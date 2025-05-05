import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/widgets/bottom_nav_bar.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class MyProfile extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final EventController eventController = Get.find<EventController>();

  MyProfile({super.key});

  void navigateTohomeScreen(BuildContext context) {
    Get.toNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.purple,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Obx(() => Text(
                  homeController.name.value,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 8),
            // Obx(() => Text(
            //       'You have subscribed to ${eventController.joinedEvents.length} events!',
            //       style: const TextStyle(fontSize: 16),
            //     )),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value:isDark,
              onChanged: (val) {
                if (val) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              key: const Key('changeNameTile'),
              tileColor: Theme.of(context).cardColor,
              leading:
                  Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
              title: Text(
                'Change name',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              onTap: () => navigateTohomeScreen(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
