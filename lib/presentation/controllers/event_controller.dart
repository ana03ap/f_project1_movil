import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  var isJoined = false.obs;
  var availableSpots = 0.obs;

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
}
