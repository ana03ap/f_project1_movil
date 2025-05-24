// import '../../data/models/event_model.dart';

// class JoinEvent {
//   void call(EventModel event) {
//     if (!event.isJoined.value && event.availableSpots.value > 0) {
//       event.isJoined.value = true;
//       event.availableSpots.value--;
//     }
//   }
// }

import 'package:f_project_1/data/models/event_model.dart';

import '../repositories/i_event_repository.dart';

/// Caso de uso: unirse a un evento
class JoinEvent {
  final IEventRepository repository;
  JoinEvent(this.repository);

  /// Llama al repositorio para marcar el evento como unido
  Future<EventModel> call(String eventId) {
    return repository.joinEvent(eventId);
  }
}
