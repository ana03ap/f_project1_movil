import 'package:f_project_1/data/models/event_model.dart';

abstract class IEventLocalDataSource {
  Future<int> getLocalVersion();
  Future<void> setLocalVersion(int version);
  Future<void> saveEvents(List<EventModel> events);
  Future<List<EventModel>> getSavedEvents();
  bool hasCachedEvents();
}
