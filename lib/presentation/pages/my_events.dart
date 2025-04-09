import 'package:f_project_1/data/events_data.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/top_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/event_card.dart';
import '../widgets/pastevent_card.dart';
import '../widgets/top_nav_bar.dart';

class MyEvents extends StatelessWidget {
  final TopNavController topNavController = Get.put(TopNavController());
  final EventController eventController = Get.find<EventController>();

  MyEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 178, 144, 184),
        title: const Text(
          'PuntoG',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:10),
        child: Column(
          children: [
            TopNavBar(),
            Expanded(
              child: Obx(() {
                if (topNavController.currentIndex.value == 0) {
                  final upcomingEvents = eventController.joinedEvents
                      .where((event) => eventController.isEventFuture(event.date))
                      .toList();
        
                  return upcomingEvents.isEmpty
                      ? _buildEmptyState("No upcoming events")
                      : ListView.builder(
                          itemCount: upcomingEvents.length,
                          itemBuilder: (context, index) {
                            final event = upcomingEvents[index];
                            return EventCard(
                              title: event.title,
                              location: event.location,
                              path: event.path,
                              date: event
                                  .date, 
                              onTap: () => _navigateToEventDetails(event),
                            );
                          },
                        );
                } else {
                  // EVENTOS PASADOS
                  final pastEvents = eventController.joinedEvents
                      .where(
                          (event) => !eventController.isEventFuture(event.date))
                      .toList();
        
                  return pastEvents.isEmpty
                      ? _buildEmptyState("No past events")
                      : ListView.builder(
                          itemCount: pastEvents.length,
                          itemBuilder: (context, index) {
                            final event = pastEvents[index];
                            return PastEventCard(
                              event: event,
                              onTap: () => _navigateToFeedback(event),
                            );
                          },
                        );
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  // ========== MÉTODOS AUXILIARES ==========
  Widget _buildEmptyState(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  void _navigateToEventDetails(Event event) {
    // 1. Guarda el evento seleccionado
    eventController.selectEvent(event);
    // 2. Navega a detalles
    Get.toNamed('/details_screen');
  }

  void _navigateToFeedback(Event event) {
    // 1. Opcional: Guarda el evento si necesitas datos en el feedback
    eventController.selectedEvent.value = event;
    Get.toNamed('/feedback');
  }


}
