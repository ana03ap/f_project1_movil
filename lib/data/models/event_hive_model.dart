import 'package:hive/hive.dart';

part 'event_hive_model.g.dart';

@HiveType(typeId: 1)
class EventHiveModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String location;

  @HiveField(3)
  final String details;

  @HiveField(4)
  final int participants;

  @HiveField(5)
  final int availableSpots;

  @HiveField(6)
  final String date;

  @HiveField(7)
  final String path;

  @HiveField(8)
  final String type;

  @HiveField(9)
  final bool isJoined;

  @HiveField(10)
  final List<double> ratings;

  EventHiveModel({
    required this.id,
    required this.title,
    required this.location,
    required this.details,
    required this.participants,
    required this.availableSpots,
    required this.date,
    required this.path,
    required this.type,
    required this.isJoined,
    this.ratings = const [],
  });
}
