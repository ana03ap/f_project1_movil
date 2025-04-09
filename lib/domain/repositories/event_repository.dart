import '../entities/event.dart';

abstract class EventRepository {
  List<Event> getAllEvents();
  List<Event> getEventsByType(String type);
  void joinEvent(int id);
  void unjoinEvent(int id);
  void addRating(int id, double rating);
}
