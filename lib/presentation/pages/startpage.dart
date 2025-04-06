import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:f_project_1/data/events_data.dart'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/container_icon_with_text.dart';
import '../widgets/event_card.dart';
import '../widgets/bottom_nav_bar.dart';

class Startpage extends StatelessWidget {
  final BottomNavController bottomNavController = Get.find();
  final EventController eventController = Get.find<EventController>();
  final HomeController homeController = Get.find<HomeController>();

  Startpage({Key? key}) : super(key: key);

  void navigateToEventDetails(Event event) {
    eventController.selectEvent({
      "title": event.title,
      "location": event.location,
      "participants": event.participants,
      "details": event.details,
      "availableSpots": event.availableSpots,
      "date": event.date,
    });

    Get.toNamed('/details_screen');
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Obx(() => Text("Hi, ${homeController.name.value}!", 
                      style: const TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    "Look for new adventures",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  ContainerIconWithText(icon: Icons.health_and_safety_outlined, label: "Sexual Health"),
                  ContainerIconWithText(icon: Icons.transgender_outlined, label: "Identity"),
                  ContainerIconWithText(icon: Icons.phone_iphone, label: "Cybertouch"),
                  ContainerIconWithText(icon: Icons.block_rounded, label: "Unbound"),
                  ContainerIconWithText(icon: Icons.menu_book, label: "Culture"),
                  ContainerIconWithText(icon: Icons.local_fire_department_rounded, label: "Sexual Ed."),
                  ContainerIconWithText(icon: Icons.wc, label: "Body Literacy"),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Events",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: eventsList.length,
                itemBuilder: (context, index) {
                  final event = eventsList[index];
                  return EventCard(
                    title: event.title,
                    location: event.location,
                    path: "", // Puedes agregar una imagen si deseas
                    onTap: () => navigateToEventDetails(event),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
