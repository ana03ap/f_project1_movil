import 'package:f_project_1/core/network/network_info.dart';
import 'package:f_project_1/data/models/event_model.dart';
import 'package:f_project_1/domain/datasources/i_event_local_data_source.dart';
import 'package:f_project_1/domain/datasources/i_event_remote_data_source.dart';
import 'package:f_project_1/domain/entities/event.dart';
import 'package:f_project_1/domain/repositories/i_event_repository.dart';
import 'package:loggy/loggy.dart';

class EventRepositoryImpl implements IEventRepository {
  final IEventLocalDataSource localDataSource;
  final IEventRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EventRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Event>> getAllEvents() async {
    List<Event> events = [];

    if (await networkInfo.isConnected()) {
      logInfo('📡 Conectado a internet');
      try {
        final remoteVersion = await remoteDataSource.fetchEventVersion();
        final localVersion = await localDataSource.getLocalVersion();

        if (remoteVersion > localVersion) {
          final apiEvents = await remoteDataSource.fetchEvents();
          await localDataSource.saveEvents(apiEvents.cast<EventModel>());
          await localDataSource.setLocalVersion(remoteVersion);
          logInfo('Nueva versión descargada: ${apiEvents.length}');
          events = apiEvents;
        } else {
          logInfo('Mismo número de versión, se usa Hive');
          events = await localDataSource.getSavedEvents();
        }
      } catch (e) {
        logError('Error al descargar desde API: $e');
        events = await localDataSource.getSavedEvents();
      }
    } else {
      logInfo('Sin internet: usando Hive');
      events = await localDataSource.getSavedEvents();
    }

    return events;
  }

  @override
  Future<void> joinEvent(String eventId) async {
    final events = await localDataSource.getSavedEvents();
    final index = events.indexWhere((e) => e.id == eventId);

    if (index != -1) {
      events[index].isJoined.value = true;
      events[index].availableSpots.value--;
      await localDataSource.saveEvents(events);
      logInfo('Persona unida al evento: $eventId');
    }
  }

  @override
  Future<void> unjoinEvent(String eventId) async {
    final events = await localDataSource.getSavedEvents();
    final index = events.indexWhere((e) => e.id == eventId);

    if (index != -1) {
      final event = events[index];
      event.isJoined.value = false;
      event.availableSpots.value += 1;
      await localDataSource.saveEvents(events);
      logInfo('Usuario se desunió del evento: $eventId');
    }
  }

  @override
  Future<void> addRating(String eventId, double rating) async {
    final events = await localDataSource.getSavedEvents();
    final index = events.indexWhere((e) => e.id == eventId);

    if (index != -1) {
      final event = events[index];
      event.ratings.add(rating);
      event.updateAverageRating();
      await localDataSource.saveEvents(events);
      logInfo('Feedback registrado en evento $eventId: $rating');
    }
  }

  @override
  Future<void> saveEvents(List<Event> events) async {
    await localDataSource.saveEvents(events.cast<EventModel>());
  }
}