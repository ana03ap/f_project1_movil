import 'package:f_project_1/data/models/event_model.dart';

import '../repositories/i_event_repository.dart';

/// Caso de uso: desunirse de un evento
class UnjoinEvent {
  final IEventRepository repository;
  UnjoinEvent(this.repository);

  /// Llama al repositorio para marcar el evento como no unido
  Future<EventModel> call(String eventId) {
    return repository.unjoinEvent(eventId);
  }
}
