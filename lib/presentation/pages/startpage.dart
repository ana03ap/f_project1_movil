import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/container_icon_with_text.dart';
import '../widgets/event_card.dart';
import '../widgets/bottom_nav_bar.dart';

class Startpage extends StatefulWidget {
  const Startpage({Key? key}) : super(key: key);

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 Mantengo la lógica para recibir el nombre desde HomeScreen
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
                )),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  EventCard(
                    title: "Voices of the future",
                    locationName: "Movistar Arena",
                    locationPlace: "Bogotá, Colombia",
                    imageColor: Colors.amber,
                  ),
                  EventCard(
                    title: "Tech Beats 2025",
                    locationName: "El Campín",
                    locationPlace: "Bogotá, Colombia",
                    imageColor: Colors.lightBlue,
                  ),
                  EventCard(
                    title: "AI in Art",
                    locationName: "Museo de Arte Moderno",
                    locationPlace: "Medellín, Colombia",
                    imageColor: Colors.pinkAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
