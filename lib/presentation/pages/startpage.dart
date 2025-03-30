import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
//import 'package:get/get.dart';

class Startpage extends StatelessWidget {
  const Startpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: const [
                      Text(
                        "NombreApp",
                      ),
                      Text(
                        "Hi, name!",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Find your news adventures",
                    ),
                    Icon(Icons.search)
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
                          icon: Icons.monetization_on_outlined,
                          label: "Finances"),
                      ContainerIconwithText(
                          icon: Icons.science, label: "Science"),
                      ContainerIconwithText(
                          icon: Icons.history, label: "History"),
                    ],
                  ),
                ),
                Container(
                    width: 400,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(249, 42, 40, 40),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    )),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Events",
                    style: TextStyle(
                      //fontFamily: 'LeagueSpartan',
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            )));
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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          width: 60,
          height: 70,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Center(
            child: Icon(icon, color: Colors.deepPurple, size: 30),
          ),
        ),
        Text(
          label,
        ),
      ],
    );
  }
}
