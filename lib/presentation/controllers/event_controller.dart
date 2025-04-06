import 'package:f_project_1/data/events_data.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EventController extends GetxController {
  var isJoined = false.obs;
  var availableSpots = 0.obs;
  var selectedEvent = Rxn<
      Map<String,
          dynamic>>(); 

   var selectedFilter = ''.obs; // 🔥 Tipo seleccionado actualmente (filtro)
  var filteredEvents = <Event>[].obs; // 🔥 Lista filtrada de eventos

  void initialize(int spots) {
    availableSpots.value = spots;
    isJoined.value = false;
  }

  void toggleJoin() {
    if (!isJoined.value && availableSpots.value > 0) {
      isJoined.value = true;
      availableSpots.value -= 1;
    } else if (isJoined.value) {
      isJoined.value = false;
      availableSpots.value += 1;
    }

    if (availableSpots.value == 0 && !isJoined.value) {
      Get.snackbar(
        'No More Spots',
        'No spots available for this event.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void selectEvent(Map<String, dynamic> event) {
   
    selectedEvent.value = event; 

    if (event.containsKey('availableSpots')) {
      int spots = event['availableSpots'];
      initialize(spots); 
    } else {
      availableSpots.value = 0;
    }
  }


    void filterEvents(String type) {
    selectedFilter.value = type;

    if (type.isEmpty) {
      filteredEvents.value = eventsList; // Mostrar todos si no hay filtro
    } else {
      filteredEvents.value = eventsList.where((event) => event.type == type).toList();
    }
  }
}
