import 'package:f_project_1/data/models/event_hive_model.dart';
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
    List<double>? ratings, 
  })  : availableSpots = RxInt(availableSpots),
        isJoined = RxBool(isJoined),
        averageRating = 0.0.obs,
        ratings = ratings ?? [], 
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


factory EventModel.fromHive(EventHiveModel hiveModel) {
  return EventModel(
    id: hiveModel.id,
    title: hiveModel.title,
    location: hiveModel.location,
    details: hiveModel.details,
    participants: hiveModel.participants,
    availableSpots: hiveModel.availableSpots,
    date: hiveModel.date,
    path: hiveModel.path,
    type: hiveModel.type,
    isJoined: hiveModel.isJoined,
    ratings: hiveModel.ratings,
  );
}

EventHiveModel toHiveModel() {
  return EventHiveModel(
    id: id,
    title: title,
    location: location,
    details: details,
    participants: participants,
    availableSpots: availableSpots.value,
    date: date,
    path: path,
    type: type,
    isJoined: isJoined.value,
    ratings: ratings,
  );
}


}

