import '../entities/event.dart';

/// Caso de uso: filtrar eventos por tipo
class FilterEvents {
  /// Si [type] está vacío, devuelve todos; si no, solo los que coinciden.
  List<Event> call(String type, List<Event> all) {
    if (type.isEmpty) return all;
    return all.where((e) => e.type == type).toList();
  }
}
