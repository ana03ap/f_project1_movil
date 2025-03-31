import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String locationName;
  final String locationPlace;
  final Color imageColor;

  const EventCard({
    Key? key,
    required this.title,
    required this.locationName,
    required this.locationPlace,
    required this.imageColor,
  }) : super(key: key);

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
      child: Row(
        children: [
          Container(
            width: 120,
            height: 130,
            decoration: BoxDecoration(
              color: imageColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(locationName),
                  Text(locationPlace),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
