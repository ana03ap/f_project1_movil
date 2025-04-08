import 'package:f_project_1/data/events_data.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';// esto es pa las fechas 

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
//MANEJO DE EVENTOS 
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


// FILTRADO
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

  // MANJEAR LAS FECHAS PAL UPCOMING Y PASE EVENTS



  bool isEventFuture(String dateString) {
    try {
      final format = DateFormat("MMMM dd, yyyy, h:mm a", "en_US");
      final eventDate = format.parse(dateString, true).toLocal();
      return eventDate.isAfter(DateTime.now().toLocal());
    } catch (e) {
      print('⚠️ Error parsing date: $dateString');
      return true; // Por defecto, lo considera futuro
    }
  }


  //FEEBACK

    void addFeedback(Event event, double rating) {
    event.ratings.add(rating); // Añade el nuevo rating a la lista
    event.updateAverageRating();
    
    // Opcional: Guardar en SharedPreferences si necesitas persistencia
    // _saveRatings(event);
    
    // Cierra el diálogo de feedback
  
    Get.snackbar('Thanks!', 'Your rating has been recorded.',snackPosition: SnackPosition.BOTTOM);
  }

}