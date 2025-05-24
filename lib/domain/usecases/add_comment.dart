import 'package:f_project_1/domain/repositories/i_event_repository.dart';

class AddComment {
  final IEventRepository repository;
  AddComment(this.repository);
  Future<void> call(String eventId, String comment) =>
      repository.addComment(eventId, comment);
}
