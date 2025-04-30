import 'package:loggy/loggy.dart';
import '../../core/network/network_info.dart';
import '../datasources/local/hive_event_source.dart';
import '../datasources/remote/remote_data_source.dart';
import '../../data/models/event_model.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';

class EventRepositoryImpl extends EventRepository {
  final HiveEventSource hiveSource;
  final RemoteDataSource remoteSource;
  final NetworkInfo networkInfo;

  EventRepositoryImpl({
    required this.hiveSource,
    required this.remoteSource,
    required this.networkInfo,
  });

  @override
  Future<List<Event>> getAllEvents() async {
    if (await networkInfo.isConnected()) {
      logInfo('📡 Conectado: intentando obtener eventos desde API...');
      try {
        final apiEvents = await remoteSource.fetchEvents();
        logInfo('✅ Eventos descargados: ${apiEvents.length}');
        await hiveSource.saveEvents(apiEvents);
        return apiEvents;
      } catch (e) {
        logError('❌ Error al descargar desde API: $e');
        final fallback = await hiveSource.loadEvents();
        logInfo('⚠️ Usando eventos locales (fallback): ${fallback.length}');
        return fallback;
      }
    } else {
      logInfo('📴 Sin internet: usando eventos de Hive');
      return await hiveSource.loadEvents();
    }
  }

  @override
  Future<void> joinEvent(int eventId) async {
    final events = await hiveSource.loadEvents();
    final index = events.indexWhere((e) => e.id == eventId);

    if (index != -1) {
      final event = events[index];
      event.isJoined.value = true;
      event.availableSpots.value -= 1;
      await hiveSource.saveEvents(events.cast<EventModel>());
      logInfo('🟢 Usuario unido a evento: $eventId');
    }
  }

  @override
  Future<void> unjoinEvent(int eventId) async {
    final events = await hiveSource.loadEvents();
    final index = events.indexWhere((e) => e.id == eventId);

    if (index != -1) {
      final event = events[index];
      event.isJoined.value = false;
      event.availableSpots.value += 1;
      await hiveSource.saveEvents(events.cast<EventModel>());
      logInfo('🔴 Usuario se desunió del evento: $eventId');
    }
  }

  @override
  Future<void> addRating(int eventId, double rating) async {
    final events = await hiveSource.loadEvents();
    final index = events.indexWhere((e) => e.id == eventId);

    if (index != -1) {
      final event = events[index];
      event.ratings.add(rating);
      event.updateAverageRating();
      await hiveSource.saveEvents(events.cast<EventModel>());
      logInfo('⭐ Feedback registrado en evento $eventId: $rating');
    }
  }
}
