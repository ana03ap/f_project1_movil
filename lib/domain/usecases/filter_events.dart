// import '../../data/models/event_model.dart';

// class FilterEvents {
//   List<EventModel> call(String type, List<EventModel> allEvents) {
//     if (type.isEmpty) {
//       return allEvents;
//     }
//     return allEvents.where((event) => event.type == type).toList();
//   }
// }

import '../entities/event.dart';

/// Caso de uso: filtrar eventos por tipo
class FilterEvents {
  /// Si [type] está vacío, devuelve todos; si no, solo los que coinciden.
  List<Event> call(String type, List<Event> all) {
    if (type.isEmpty) return all;
    return all.where((e) => e.type == type).toList();
  }
}
