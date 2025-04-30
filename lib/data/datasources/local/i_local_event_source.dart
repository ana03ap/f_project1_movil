import 'package:f_project_1/domain/entities/event.dart';

abstract class ILocalEventSource {
  Future<void> init();
  Future<List<Event>> loadEvents();
  Future<void> saveEvents(List<Event> events);
  bool hasCachedEvents();
}
