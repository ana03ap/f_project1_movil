import 'package:flutter/material.dart';

class ContainerIconWithText extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const ContainerIconWithText({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.purple.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.purple : Colors.grey,
            size: 30,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.purple : Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
