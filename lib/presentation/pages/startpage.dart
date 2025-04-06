import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/container_icon_with_text.dart';
import '../widgets/event_card.dart';
import '../widgets/bottom_nav_bar.dart';

class Startpage extends StatelessWidget {
  final BottomNavController bottomNavController = Get.find();
  final EventController eventController =
      Get.find<EventController>(); // Obtener el controlador globalmente
  Startpage({Key? key}) : super(key: key);

  void navigateToEventDetails(String title, String location, String details,
      int participants, int availableSpots, String date) {
    // 🔥 Ahora llamamos a selectEvent() en lugar de asignar selectedEvent directamente.
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
                  const Text("NombreApp",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text("Hi, $name!",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Find your news adventures",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Icon(Icons.search),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  ContainerIconWithText(icon: Icons.heart_broken_sharp, label: "Romance"),
                  ContainerIconWithText(icon: Icons.policy_outlined, label: "Politics"),
                  ContainerIconWithText(icon: Icons.brush, label: "Art"),
                  ContainerIconWithText(icon: Icons.sports_soccer_sharp, label: "Sport"),
                  ContainerIconWithText(icon: Icons.monetization_on_outlined, label: "Finances"),
                  ContainerIconWithText(icon: Icons.science, label: "Science"),
                  ContainerIconWithText(icon: Icons.history, label: "History"),
                ],
              ),
            ),
            Container(
              width: 400,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(249, 42, 40, 40),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4, top: 10),
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
                    imageColor: Colors.amber,
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
                    imageColor: Colors.lightBlue,
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
                    imageColor: Colors.pinkAccent,
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
