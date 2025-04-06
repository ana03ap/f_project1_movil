import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/container_icon_with_text.dart';
import '../widgets/event_card.dart';
import '../widgets/bottom_nav_bar.dart';

class Startpage extends StatelessWidget {
  final BottomNavController bottomNavController = Get.find();
  final EventController eventController = Get.find<EventController>();
  final TextEditingController nameController = TextEditingController();
  final RxString name = ''.obs;
  Startpage({Key? key}) : super(key: key);

  void navigateToEventDetails(String title, String location, String details,
      int participants, int availableSpots, String date) {
    eventController.selectEvent({
      "title": title,
      "location": location,
      "participants": participants,
      "details": details,
      "availableSpots": availableSpots,
      "date": date,
    });

    Get.toNamed('/details_screen');
  }

  @override
  Widget build(BuildContext context) {
    final String name = Get.arguments ?? 'Guest';

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
                  Text("Hi, $name!",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
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
                  ContainerIconWithText(
                      icon: Icons.health_and_safety_outlined,
                      label: "Sexual Health"),
                  ContainerIconWithText(
                      icon: Icons.transgender_outlined, label: "Identity"),
                  ContainerIconWithText(
                      icon: Icons.phone_iphone, label: "Cybertouch"),
                  ContainerIconWithText(
                      icon: Icons.block_rounded, label: "Unbound"),
                  ContainerIconWithText(
                      icon: Icons.menu_book, label: "Culture"),
                  ContainerIconWithText(
                      icon: Icons.local_fire_department_rounded,
                      label: "Sexual Ed."),
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
              child: ListView(
                children: [
                  EventCard(
                    title: "Voices of the Future",
                    locationName: "Movistar Arena",
                    locationPlace: "Bogotá, Colombia",
                    path: "",
                    onTap: () => navigateToEventDetails(
                      "Voices of the Future",
                      "Movistar Arena / Bogotá, Colombia",
                      "The Voices of the Future event is a transformative gathering dedicated to inspiring, educating, and equipping young leaders, visionaries, and innovators who are shaping the future of our world. This unique experience provides a platform for meaningful dialogue, collaboration, and action, bringing together bright minds from diverse backgrounds to address the most pressing challenges of our time",
                      20,
                      10,
                      "04 APRIL 2025\nFriday, 10:00 AM",
                    ),
                  ),
                  EventCard(
                    title: "Tech Beats 2025",
                    locationName: "El Campín",
                    locationPlace: "Bogotá, Colombia",
                    path: "",
                    onTap: () => navigateToEventDetails(
                      "Tech Beats 2025",
                      "El Campín / Bogotá, Colombia",
                      "A tech conference showcasing the latest innovations in AI, cybersecurity, and web development.",
                      50,
                      25,
                      "10 MAY 2025\nSaturday, 09:00 AM",
                    ),
                  ),
                  EventCard(
                    title: "AI in Art",
                    locationName: "Museo de Arte Moderno",
                    locationPlace: "Medellín, Colombia",
                    path: "",
                    onTap: () => navigateToEventDetails(
                      "AI in Art",
                      "Museo de Arte Moderno / Medellín, Colombia",
                      "Exploring the intersection of artificial intelligence and visual arts. Exhibitions of generative art and more.",
                      30,
                      15,
                      "15 JUNE 2025\nSunday, 11:00 AM",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
