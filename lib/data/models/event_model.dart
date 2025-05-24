import 'package:f_project_1/data/models/event_hive_model.dart';
import 'package:get/get.dart';
import '../../domain/entities/event.dart';

class EventModel extends Event {
  RxInt availableSpots;
  RxBool isJoined;
  RxDouble averageRating;
  final List<double> ratings;
  final List<String> comments;

  EventModel({
    required String id,
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
    List<String>? comments,
  })  : comments = comments ?? [],
        availableSpots = RxInt(availableSpots),
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
        ) {
    updateAverageRating();
  }

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
      comments: hiveModel.comments,
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
      comments: comments,
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      details: json['details'] ?? '',
      participants: json['participants'] ?? 0,
      availableSpots: json['availableSpots'] ??
          0, // <- int plano, se convierte en constructor
      date: json['date'] ?? '',
      path: json['path'] ?? '',
      type: json['type'] ?? '',
      isJoined: (json['isJoined'] as bool?) ?? false,
      ratings: (json['ratings'] != null)
          ? List<double>.from(
              (json['ratings'] as List).map((e) => (e as num).toDouble()))
          : [],

      comments: (json['comments'] ?? []).cast<String>(),
    );
  }
}
