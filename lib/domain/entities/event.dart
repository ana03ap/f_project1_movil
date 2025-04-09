class Event {
  final int id;
  final String title;
  final String location;
  final String details;
  final int participants;
  final String date;
  final String path;
  final String type;

  const Event({
    required this.id,
    required this.title,
    required this.location,
    required this.details,
    required this.participants,
    required this.date,
    required this.path,
    required this.type,
  });
}