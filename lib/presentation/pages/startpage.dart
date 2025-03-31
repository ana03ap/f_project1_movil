import 'package:flutter/material.dart';

class Startpage extends StatelessWidget {
  const Startpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Center(
              child: Column(
                children: [
                  Text("NombreApp",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text("Hi, name!",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Find your news adventures",
                    style:
                        //podria ser algo comun
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
                  ContainerIconwithText(
                      icon: Icons.heart_broken_sharp, label: "Romance"),
                  ContainerIconwithText(
                      icon: Icons.policy_outlined, label: "Politics"),
                  ContainerIconwithText(icon: Icons.brush, label: "Art"),
                  ContainerIconwithText(
                      icon: Icons.sports_soccer_sharp, label: "Sport"),
                  ContainerIconwithText(
                      icon: Icons.monetization_on_outlined, label: "Finances"),
                  ContainerIconwithText(icon: Icons.science, label: "Science"),
                  ContainerIconwithText(icon: Icons.history, label: "History"),
                ],
              ),
            ),
            // Hacer la imagen en canva
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
    );
  }
}

class ContainerIconwithText extends StatelessWidget {
  const ContainerIconwithText({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 70,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 240, 240, 240),
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.deepPurple,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String locationName;
  final String locationPlace;
  final Color imageColor;

  const EventCard({
    super.key,
    required this.title,
    required this.locationName,
    required this.locationPlace,
    required this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 370,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0, top: 5),
              child: Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locationName,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 60, 31, 110)),
                          ),
                          Text(
                            locationPlace,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 60, 31, 110)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  // aqui va imagen de cada evento, realizarla!
                  width: 120,
                  height: 75,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: imageColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}