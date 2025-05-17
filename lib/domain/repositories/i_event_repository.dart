import '../entities/event.dart';

abstract class IEventRepository {
  Future<List<Event>> getAllEvents();
  Future<void> joinEvent(String eventId);
  Future<void> unjoinEvent(String eventId);
  Future<void> addRating(String eventId, double rating);
  Future<void> saveEvents(List<Event> events);
}
