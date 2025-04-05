import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../controllers/top_nav_controller.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/event_card.dart';
import '../widgets/pastevent_card.dart';

class MyEvents extends StatelessWidget {
  final TopNavController topNavController = Get.put(TopNavController());
  final EventController eventController =
      Get.find<EventController>(); // Obtener el controlador globalmente
  MyEvents({Key? key}) : super(key: key);

  void navigateToEventDetails(String title, String location, String details,
      int participants, int availableSpots, String date) {

    // Cambiar a usar el controlador en lugar de pasar arguments
    eventController.selectedEvent.value = {
      "title": title,
      "location": location,
      "participants": participants,
      "details": details,
      "availableSpots": availableSpots,
      "date": date,
    };

    Get.toNamed('/details_screen');
  }

  void navigateToFeedback() {
    Get.toNamed('/feedback');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TuBoleta'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          TopNavBar(),
          Expanded(
            child: Obx(() {
              return topNavController.currentIndex.value == 0
                  ? ListView(
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
                            "04 ABRIL 2025\nViernes, 10:00 AM",
                          ),
                        ),
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
                            "04 ABRIL 2025\nViernes, 10:00 AM",
                          ),
                        ),
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
                            "04 ABRIL 2025\nViernes, 10:00 AM",
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      children: [
                        PastEventCard(
                          title: "Voices of the Future",
                          onTap: () => navigateToFeedback(),
                        ),
                        PastEventCard(
                          title: "Voices of the Future",
                          onTap: () => navigateToFeedback(),
                        ),
                        PastEventCard(
                          title: "Voices of the Future",
                          onTap: () => navigateToFeedback(),
                        ),
                        PastEventCard(
                          title: "Voices of the Future",
                          onTap: () => navigateToFeedback(),
                        ),
                      ],
                    );
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
