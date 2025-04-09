import 'package:get/get.dart';
import '../../domain/entities/event.dart';

class EventModel extends Event {
  RxInt availableSpots;
  RxBool isJoined;
  RxDouble averageRating;
  final List<double> ratings;

  EventModel({
    required int id,
    required String title,
    required String location,
    required String details,
    required int participants,
    required int availableSpots,
    required String date,
    required String path,
    required String type,
    bool isJoined = false,
    this.ratings = const [],
  })  : availableSpots = RxInt(availableSpots),
        isJoined = RxBool(isJoined),
        averageRating = 0.0.obs,
        super(
          id: id,
          title: title,
          location: location,
          details: details,
          participants: participants,
          date: date,
          path: path,
          type: type,
        );

  void updateAverageRating() {
    averageRating.value = ratings.isEmpty
        ? 0.0
        : ratings.reduce((a, b) => a + b) / ratings.length;
  }
}
