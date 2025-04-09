import '../../data/models/event_model.dart';

class UnjoinEvent {
  void call(EventModel event) {
    if (event.isJoined.value) {
      event.isJoined.value = false;
      event.availableSpots.value++;
    }
  }
}
