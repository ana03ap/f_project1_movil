import 'package:f_project_1/data/events_data.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final RxList<Event> joinedEvents = <Event>[].obs;
  final RxList<Event> filteredEvents = <Event>[].obs;
  final Rxn<Event> selectedEvent = Rxn<Event>();
  final RxString selectedFilter = ''.obs;
  
  // Nota: availableSpots ahora es manejado por cada Event individualmente

  @override
  void onInit() {
    super.onInit();
    resetFilter();
  }

  void selectEvent(Event event) {
    selectedEvent.value = event;
  }

  void toggleJoinEvent(Event event) {
    if (event.isJoined.value) {
      unjoinEvent(event);
    } else {
      joinEvent(event);
    }
  }

  void joinEvent(Event event) {
    if (event.availableSpots.value > 0) {
      event.isJoined.value = true;
      event.availableSpots.value--;
      
      if (!joinedEvents.any((e) => e.id == event.id)) {
        joinedEvents.add(event);
      }
      
      updateFilteredEvents();
    }
  }

  void unjoinEvent(Event event) {
    event.isJoined.value = false;
    event.availableSpots.value++;
    joinedEvents.removeWhere((e) => e.id == event.id);
    updateFilteredEvents();
  }

  void filterEvents(String type) {
    selectedFilter.value = type;
    updateFilteredEvents();
  }

  void resetFilter() {
    selectedFilter.value = '';
    updateFilteredEvents();
  }

  void updateFilteredEvents() {
    if (selectedFilter.value.isEmpty) {
      filteredEvents.assignAll(eventsList);
    } else {
      filteredEvents.assignAll(
        eventsList.where((event) => event.type == selectedFilter.value),
      );
    }
  }
}