import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../controllers/top_nav_controller.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/event_card.dart';
import '../widgets/pastevent_card.dart';
import '../../core/constants/app_assets.dart';

class MyEvents extends StatelessWidget {
  final TopNavController topNavController = Get.put(TopNavController());
  final EventController eventController = Get.find<EventController>();
  MyEvents({Key? key}) : super(key: key);

  void navigateToEventDetails(String title, String location, String details,
      int participants, int availableSpots, String date) {
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
        title: const Text('PuntoG'),
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
                      // DATOS ESTATICOS DE MUESTRA, DON TOUCH IT
                      children: [
                        EventCard(
                          title: "Reproductive Justice",
                          locationName: "Hall B1",
                          locationPlace: "Convention Center",
                          path: AppAssets.sexRights,
                          onTap: () => navigateToEventDetails(
                            "Reproductive Justice: Rights and Realities",
                            "Hall B1 / Convention Center",
                            "Exploring how reproductive justice intersects with social, economic, and racial equity...",
                            60,
                            22,
                            "19 APRIL 2025\nSaturday, 10:00 AM",
                          ),
                        ),
                        EventCard(
                          title: "Understanding Contraceptive Options",
                          locationName: "Room 2A",
                          locationPlace: "Health Pavilion",
                          path: 'lib/assets/sexualrights.png',
                          onTap: () => navigateToEventDetails(
                            "Understanding Contraceptive Options",
                            "Room 2A / Health Pavilion",
                            "Exploring modern contraceptive methods, how they work, and who benefits the most...",
                            50,
                            17,
                            "19 APRIL 2025\nSaturday, 12:00 PM",
                          ),
                        ),
                        EventCard(
                          title: "Emergency Contraception",
                          locationName: "Advocacy Center",
                          locationPlace: "Downtown Campus",
                          path: 'AppAssets.sexRights',
                          onTap: () => navigateToEventDetails(
                            "Emergency Contraception: Myths and Facts",
                            "Advocacy Center / Downtown Campus",
                            "Debunking misconceptions about emergency contraception and discussing accessibility...",
                            45,
                            19,
                            "19 APRIL 2025\nSaturday, 2:00 PM",
                          ),
                        ),
                        EventCard(
                          title: "Menstrual Health Matters",
                          locationName: "Room C3",
                          locationPlace: "Equity Hub",
                          path: 'AppAssets.sexRights',
                          onTap: () => navigateToEventDetails(
                            "Menstrual Equity and Public Policy",
                            "Room C3 / Equity Hub",
                            "Analyzing how menstrual poverty affects global communities and what public policies exist...",
                            40,
                            12,
                            "20 APRIL 2025\nSunday, 9:00 AM",
                          ),
                        ),
                        EventCard(
                          title: "Access to Safe Abortions",
                          locationName: "Main Auditorium",
                          locationPlace: "Convention Center",
                          path: 'AppAssets.sexRights',
                          onTap: () => navigateToEventDetails(
                            "Access to Safe Abortions: Legal and Medical Perspectives",
                            "Main Auditorium / Convention Center",
                            "Exploring access to safe abortions from legal and medical perspectives...",
                            100,
                            38,
                            "20 APRIL 2025\nSunday, 11:00 AM",
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      children: [
                        PastEventCard(
                          title: "Reproductive Justice",
                          path: 'AppAssets.sexRights',
                          score: "4.5",
                          onTap: () => navigateToFeedback(),
                        ),
                        PastEventCard(
                          title: "Understanding Contraceptive Options Today",
                          path: 'AppAssets.sexRights',
                          score: "3.0",
                          onTap: () => navigateToFeedback(),
                        ),
                        PastEventCard(
                          title: "Access to Safe Abortions",
                          path: 'AppAssets.sexRights',
                          score: "4.5",
                          onTap: () => navigateToFeedback(),
                        ),
                        PastEventCard(
                          title: "Menstrual Equity and Public Policy",
                          path: 'AppAssets.sexRights',
                          score: "4.0",
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
