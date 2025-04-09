import '../../data/models/event_model.dart';

class JoinEvent {
  void call(EventModel event) {
    if (!event.isJoined.value && event.availableSpots.value > 0) {
      event.isJoined.value = true;
      event.availableSpots.value--;
    }
  }
}
