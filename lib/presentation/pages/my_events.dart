import 'package:f_project_1/data/events_data.dart';
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

//ESTO POR AHORA ESTÁ ESTATICO, NO SE HA IMPLEMENTADO QUE AL DAR JOIN SE GUARDE PORQUE NO HAY BACKEND
class MyEvents extends StatelessWidget {
  final TopNavController topNavController = Get.put(TopNavController());
  final EventController eventController = Get.find<EventController>();

  MyEvents({Key? key}) : super(key: key);

  void navigateToEventDetails(Event event) {
    eventController.selectEvent(event);
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
                  ? Obx(() {
            final joinedEvents = eventController.joinedEvents
                .where((event) => event.isJoined.value)
                .toList();
                
            return joinedEvents.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "No te has unido a ningún evento",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : ListView(
                    children: joinedEvents
                        .map((event) => EventCard(
                              title: event.title,
                              location: event.location,
                              path: event.path,
                              date: event.date,
                              onTap: () => navigateToEventDetails(event),
                            ))
                        .toList(),
                  );
          })
                  : ListView(
                      children: [
                        PastEventCard(
                          title: "Reproductive Justice",
                          path: AppAssets.sexRights,
                          date: "April 20, 2025, 9:00 AM",
                          score: "4.5",
                          onTap: () => navigateToFeedback(),
                        ),
                        PastEventCard(
                          title: "Understanding Contraceptive Options Today",
                          path: AppAssets.sexRights,
                          date: "April 20, 2025, 9:00 AM",
                          score: "3.0",
                          onTap: () => navigateToFeedback(),
                        ),
                        PastEventCard(
                          title: "Access to Safe Abortions",
                          path: AppAssets.sexRights,
                          date: "April 20, 2025, 9:00 AM",
                          score: "4.5",
                          onTap: () => navigateToFeedback(),
                        ),
                        PastEventCard(
                          title: "Menstrual Equity and Public Policy",
                          path: AppAssets.sexRights,
                          date: "April 20, 2025, 9:00 AM",
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
