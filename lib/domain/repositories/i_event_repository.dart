import 'package:f_project_1/data/models/event_model.dart';

import '../entities/event.dart';

abstract class IEventRepository {
  Future<List<Event>> getAllEvents();
  Future<EventModel> joinEvent(String id);
  Future<EventModel> unjoinEvent(String id);
  Future<void> addRating(String eventId, double rating);
  Future<void> saveEvents(List<Event> events);
  Future<void> addComment(String eventId, String comment);
}
