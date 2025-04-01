import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/constants/app_assets.dart';
import '../widgets/bottom_nav_bar.dart';
import '../controllers/bottom_nav_controller.dart';

class EventDetailsScreen extends StatelessWidget {
  final BottomNavController bottomNavController = Get.find();

  EventDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 🔥 Recibimos los parámetros que se pasaron desde StartPage
    final Map<String, dynamic> eventDetails = Get.arguments ?? {
      "title": "Evento Desconocido",
      "location": "Ubicación Desconocida",
      "participants": 0,
      "details": "No hay detalles disponibles.",
      "availableSpots": 0,
      "date": "Fecha Desconocida",
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('TuBoleta'),
        centerTitle: true,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.asset(
                    AppAssets.eventImage,
                    fit: BoxFit.cover,
                    height: 180,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey,
                        child: const Center(child: Text('Image not found')),
                      );
                    },
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 180,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      eventDetails["date"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(eventDetails["title"], style: AppStyles.title),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primary),
                const SizedBox(width: 5),
                Text(eventDetails["location"], style: AppStyles.normal),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.people, color: AppColors.primary),
                const SizedBox(width: 5),
                Text('Maximum number of participants: ${eventDetails["participants"]}', style: AppStyles.normal),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Details', style: AppStyles.subtitle),
            const SizedBox(height: 8),
            Text(eventDetails["details"], style: AppStyles.normal),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.buttonBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('Available spots: ${eventDetails["availableSpots"]}', style: AppStyles.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Join!', style: AppStyles.subtitle),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
