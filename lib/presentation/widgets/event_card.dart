import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String locationName;
  final String locationPlace;
  final Color imageColor;
  final VoidCallback onTap;

  const EventCard({
    Key? key,
    required this.title,
    required this.locationName,
    required this.locationPlace,
    required this.imageColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(20),
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
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
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
                      height: 70,
                      margin: const EdgeInsets.only(right: 20),
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
        ));
  }
}
