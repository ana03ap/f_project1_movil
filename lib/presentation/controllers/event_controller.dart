import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EventController extends GetxController {
  var isJoined = false.obs;
  var availableSpots = 0.obs;
  var selectedEvent = Rxn<
      Map<String,
          dynamic>>(); // Permitir que sea null inicialmente y acepta un Map

  void initialize(int spots) {
    print("🟢 Inicializando con spots: $spots"); // Debug Mejorado
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
    print("🟡 Evento recibido: $event"); // Debug Mejorado
    selectedEvent.value = event; // Asignar el evento seleccionado

    if (event.containsKey('availableSpots')) {
      int spots = event['availableSpots'];
      initialize(spots); // Llamar a initialize con el valor obtenido
    } else {
      availableSpots.value = 0;
    }

    print(
        "🔵 Available Spots seteados a: ${availableSpots.value}"); // Debug Mejorado
  }
}
