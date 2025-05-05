// import '../../data/models/event_model.dart';

// class UnjoinEvent {
//   void call(EventModel event) {
//     if (event.isJoined.value) {
//       event.isJoined.value = false;
//       event.availableSpots.value++;
//     }
//   }
// }


import '../repositories/i_event_repository.dart';

/// Caso de uso: desunirse de un evento
class UnjoinEvent {
  final IEventRepository repository;
  UnjoinEvent(this.repository);

  /// Llama al repositorio para marcar el evento como no unido
  Future<void> call(int eventId) {
    return repository.unjoinEvent(eventId);
  }
}
