import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class MyProfile extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final EventController eventController = Get.find<EventController>();

  MyProfile({super.key});

  void navigateTohomeScreen(BuildContext context) {
    AdaptiveTheme.of(context).setLight();
    Get.offAllNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 80, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Obx(() => Text(
                      homeController.name.value,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Obx(() {
            final eventCount = eventController.joinedEvents.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events_rounded,
                          color: Colors.amber, size: 40),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'You have subscribed to $eventCount event${eventCount == 1 ? '!' : 's!'}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          ListTile(
            tileColor: Theme.of(context).cardColor,
            leading:
                Icon(Icons.dark_mode, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Dark mode',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            trailing: Switch(
              value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
              onChanged: (bool value) {
                if (value) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              },
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).cardColor,
            leading: Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Change name',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Theme.of(context).iconTheme.color),
            onTap: () => navigateTohomeScreen(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
