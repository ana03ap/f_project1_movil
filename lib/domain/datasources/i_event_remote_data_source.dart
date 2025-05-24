import 'package:f_project_1/data/models/event_model.dart';

abstract class IEventRemoteDataSource {
  Future<List<EventModel>> fetchEvents();
  Future<EventModel> subscribeToEvent(String id);
  Future<EventModel> unsubscribeFromEvent(String id);
  Future<void> sendFeedback(String id, int rating, String comment);
  Future<List<double>> addRating(String eventId, double rating);
  Future<List<String>> addComment(String eventId, String comment);

  Future<int> fetchEventVersion();
}
