import 'package:f_project_1/data/models/event_model.dart';


abstract class IEventRemoteDataSource {
  Future<List<EventModel>> fetchEvents();
  Future<void> subscribeToEvent(String id);
  Future<void> sendFeedback(String id, int rating, String comment);
  Future<int> fetchEventVersion();
}
