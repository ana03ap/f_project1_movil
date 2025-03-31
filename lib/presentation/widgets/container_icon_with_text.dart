import 'package:flutter/material.dart';

class ContainerIconWithText extends StatelessWidget {
  final IconData icon;
  final String label;

  const ContainerIconWithText({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

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
