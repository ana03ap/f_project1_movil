import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/container_icon_with_text.dart';
import '../widgets/event_card.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:f_project_1/data/events_data.dart';

class Startpage extends StatelessWidget {
  final BottomNavController bottomNavController = Get.find();
  final EventController eventController = Get.find<EventController>();
  final HomeController homeController = Get.find<HomeController>();

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "type": "", "icon": Icons.dashboard_customize},
    {
      "label": "Sexual Health",
      "type": "sexHealth",
      "icon": Icons.health_and_safety_outlined
    },
    {
      "label": "Identity",
      "type": "Identity",
      "icon": Icons.transgender_outlined
    },
    {"label": "Cybertouch", "type": "Cybertouch", "icon": Icons.phone_iphone},
    {"label": "Unbound", "type": "Unbound", "icon": Icons.block_rounded},
    {"label": "Culture", "type": "culture", "icon": Icons.menu_book},
    {
      "label": "Sexual Ed.",
      "type": "education",
      "icon": Icons.local_fire_department_rounded
    },
    {"label": "Body Literacy", "type": "bodyliteracy", "icon": Icons.wc},
  ];

  Startpage({Key? key}) : super(key: key);

  void navigateToEventDetails(Event event) {
    eventController.selectEvent(event);
    Get.toNamed('/details_screen');
  }

  String _getTitleText() {
    if (eventController.selectedFilter.value.isEmpty) {
      return "All Events";
    }

    final category = categories.firstWhere(
      (cat) => cat['type'] == eventController.selectedFilter.value,
      orElse: () =>
          {"label": eventController.selectedFilter.value, "icon": Icons.event},
    );

    return "${category['label']} Events";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const Text("PuntoG",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Obx(() => Text("Hi, ${homeController.name.value}!",
                      style: const TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Look for new adventures",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // LISTA DE CATEGORÍAS CORREGIDA
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Obx(() {
                    final isSelected = eventController.selectedFilter.value ==
                        category['type'];
                    return GestureDetector(
                      onTap: () =>
                          eventController.filterEvents(category['type']),
                      child: ContainerIconWithText(
                        icon: category['icon'],
                        label: category['label'],
                        isSelected: isSelected,
                      ),
                    );
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Obx(() => Text(
                      _getTitleText(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            // LISTA DE EVENTOS
            Expanded(
              child: Obx(() {
                if (eventController.filteredEvents.isEmpty) {
                  return const Center(
                    child: Text("No events found"),
                  );
                }
                return ListView.builder(
                  itemCount: eventController.filteredEvents.length,
                  itemBuilder: (context, index) {
                    final event = eventController.filteredEvents[index];
                    return EventCard(
                      title: event.title,
                      date: event.date,
                      location: event.location,
                      path: event.path,
                      onTap: () => navigateToEventDetails(event),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
