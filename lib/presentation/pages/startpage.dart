import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/container_icon_with_text.dart';
import '../widgets/event_card.dart';
import '../widgets/bottom_nav_bar.dart';


class Startpage extends StatelessWidget {
  final BottomNavController bottomNavController = Get.find();  // ✅ Controlador ya existente

  Startpage({Key? key}) : super(key: key);

  void navigateToEventDetails(String title, String location, String details,
      int participants, int availableSpots, String date) {
    Get.toNamed('/details_screen', arguments: {
      "title": title,
      "location": location,
      "participants": participants,
      "details": details,
      "availableSpots": availableSpots,
      "date": date,
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 Recibimos la variable `name` usando Get.arguments
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
                Text("Find your news adventures",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
                      icon: Icons.heart_broken_sharp, label: "Romance"),
                  ContainerIconWithText(
                      icon: Icons.policy_outlined, label: "Politics"),
                  ContainerIconWithText(icon: Icons.brush, label: "Art"),
                  ContainerIconWithText(
                      icon: Icons.sports_soccer_sharp, label: "Sport"),
                  ContainerIconWithText(
                      icon: Icons.monetization_on_outlined, label: "Finances"),
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
                )),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  EventCard(
                    title: "Voices of the Future",
                    locationName: "Movistar Arena / Bogotá, Colombia",
                    locationPlace: "Bogotá, Colombia",
                    imageColor: Colors.amber,
                    onTap: () => navigateToEventDetails(
                      "Voices of the Future",
                      "Movistar Arena / Bogotá, Colombia",
                      "Evento centrado en empoderar a los jóvenes líderes y creadores de cambio futuro. Únete a debates clave y discusiones dinámicas sobre los problemas más urgentes de hoy.",
                      20,
                      10,
                      "04 ABRIL 2025\nViernes, 10:00 AM",
                    ),
                  ),
                  EventCard(
                    title: "Tech Beats 2025",
                    locationName: "El Campín / Bogotá, Colombia",
                    locationPlace: "Bogotá, Colombia",
                    imageColor: Colors.lightBlue,
                    onTap: () => navigateToEventDetails(
                      "Tech Beats 2025",
                      "El Campín / Bogotá, Colombia",
                      "Una conferencia tecnológica con las últimas innovaciones en IA, ciberseguridad y desarrollo web.",
                      50,
                      25,
                      "10 MAYO 2025\nSábado, 09:00 AM",
                    ),
                  ),
                  EventCard(
                    title: "AI in Art",
                    locationName: "Museo de Arte Moderno / Medellín, Colombia",
                    locationPlace: "Medellín, Colombia",
                    imageColor: Colors.pinkAccent,
                    onTap: () => navigateToEventDetails(
                      "AI in Art",
                      "Museo de Arte Moderno / Medellín, Colombia",
                      "Explorando la intersección de la inteligencia artificial y las artes visuales. Exhibiciones de arte generativo y más.",
                      30,
                      15,
                      "15 JUNIO 2025\nDomingo, 11:00 AM",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),  // ✅ Usando tu controlador centralizado
    );
  }
}
