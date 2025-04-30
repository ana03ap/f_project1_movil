import '../entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getAllEvents();
  Future<void> joinEvent(int eventId);
  Future<void> unjoinEvent(int eventId);
  Future<void> addRating(int eventId, double rating);
}
