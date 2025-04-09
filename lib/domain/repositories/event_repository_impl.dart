import 'package:f_project_1/data/datasources/events_data.dart';
import 'package:f_project_1/data/models/event_model.dart';

import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final List<EventModel> _events = eventsList;

  @override
  List<Event> getAllEvents() => _events;

  @override
  List<Event> getEventsByType(String type) {
    return _events.where((e) => e.type == type).toList();
  }

  @override
  void joinEvent(int id) {
    final event = _events.firstWhere((e) => e.id == id);
    if (!event.isJoined.value && event.availableSpots.value > 0) {
      event.isJoined.value = true;
      event.availableSpots.value--;
    }
  }

  @override
  void unjoinEvent(int id) {
    final event = _events.firstWhere((e) => e.id == id);
    if (event.isJoined.value) {
      event.isJoined.value = false;
      event.availableSpots.value++;
    }
  }

  @override
  void addRating(int id, double rating) {
    final event = _events.firstWhere((e) => e.id == id);
    event.ratings.add(rating);
    event.updateAverageRating();
  }
}
