import '../entities/event.dart';

abstract class IEventRepository {
  Future<List<Event>> getAllEvents();
  Future<void> joinEvent(int eventId);
  Future<void> unjoinEvent(int eventId);
  Future<void> addRating(int eventId, double rating);
  Future<void> saveEvents(List<Event> events);
}
