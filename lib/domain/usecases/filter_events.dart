import '../../data/models/event_model.dart';

class FilterEvents {
  List<EventModel> call(String type, List<EventModel> allEvents) {
    if (type.isEmpty) {
      return allEvents;
    }
    return allEvents.where((event) => event.type == type).toList();
  }
}
