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

//   @override
//   Future<List<Event>> getAllEvents() async {
//     List<Event> events = [];

//     if (await networkInfo.isConnected()) {
//       logInfo('📡 Conectado a internet');
//       try {
//         // 1) Comparo versiones
//         final remoteVersion = await remoteDataSource.fetchEventVersion();
//         final localVersion = await localDataSource.getLocalVersion();

//         if (remoteVersion > localVersion) {
//           logInfo('Nueva versión detectada, descargando eventos...');
//           final apiEvents = await remoteDataSource.fetchEvents(); //traer la api

// // 3) Merge: conservo isJoined local
//           final savedEvents = await localDataSource.getSavedEvents();
//           final joinMap = {for (var e in savedEvents) e.id: e.isJoined.value};
//           for (var ev in apiEvents) {
//             ev.isJoined.value = joinMap[ev.id] ?? false;
//           }

//           await localDataSource.saveEvents(apiEvents.cast<EventModel>());
//           await localDataSource.setLocalVersion(remoteVersion);
//           logInfo('Nueva versión descargada: ${apiEvents.length}');
//           events = apiEvents;

//         } else {
//           logInfo('Mismo número de versión, se usa Hive');
//           events = await localDataSource.getSavedEvents();
//         }
//       } catch (e) {
//         logError('Error al descargar desde API: $e');
//         events = await localDataSource.getSavedEvents();
//       }
//     } else {
//       logInfo('Sin internet: usando Hive');
//       events = await localDataSource.getSavedEvents();
//     }

//     return events;
//   }

@override
Future<List<Event>> getAllEvents() async {
  List<Event> events = [];

  if (await networkInfo.isConnected()) {
    logInfo('📡 Conectado a internet');
    try {
      // 1) Comparar versiones
      final remoteVersion = await remoteDataSource.fetchEventVersion();
      final localVersion  = await localDataSource.getLocalVersion();

      if (remoteVersion > localVersion) {
        logInfo('Nueva versión detectada, descargando eventos...');
        // 2) Traer de la API (lista de EventModel)
        final apiEvents = await remoteDataSource.fetchEvents();

        // 3) Fusionar el estado local de isJoined sin pisar el valor remoto
        final savedEvents = await localDataSource.getSavedEvents();
        final joinMap = { for (var e in savedEvents) e.id : e.isJoined.value };
        for (var ev in apiEvents) {
          if (joinMap.containsKey(ev.id)) {
            ev.isJoined.value = joinMap[ev.id]!;
          }
          // si no hay entrada en joinMap, se respeta el isJoined que vino del JSON
        }

        // 4) Persistir la lista completa en Hive y actualizar versión
        await localDataSource.saveEvents(apiEvents);
        await localDataSource.setLocalVersion(remoteVersion);
        logInfo('Nueva versión descargada: ${apiEvents.length} eventos');

        // 5) Asignar a la lista de retorno, casteando a Event para cumplir la firma
        events = apiEvents.cast<Event>();
      } else {
        logInfo('Misma versión, usando datos de Hive');
        events = await localDataSource.getSavedEvents();
      }
    } catch (e) {
      logError('Error al descargar desde API: $e');
      events = await localDataSource.getSavedEvents();
    }
  } else {
    logInfo('🚫 Sin internet, usando datos de Hive');
    events = await localDataSource.getSavedEvents();
  }

  return events;
}

  @override
  Future<EventModel> joinEvent(String eventId) async {
    // 1. Llamada al backend que decrementa availableSpots y devuelve el evento actualizado
    final updatedEvent = await remoteDataSource.subscribeToEvent(eventId);
    // 2. Obtienes todos los eventos en Hive
    final events = await localDataSource.getSavedEvents();
    // 3. Encuentras el índice y marcas como unido
    final index = events.indexWhere((e) => e.id == eventId);
    if (index != -1) {
      events[index].isJoined.value = true;
      // 4. ¡Importante! Usas el valor que vino del backend
      events[index].availableSpots.value = updatedEvent.availableSpots.value;
      // 5. Guardas de nuevo en Hive
      await localDataSource.saveEvents(events);
      logInfo('Persona unida al evento: $eventId');
    }
    return events[index];
  }

  @override
  Future<EventModel> unjoinEvent(String eventId) async {
    final updatedEvent = await remoteDataSource.unsubscribeFromEvent(eventId);

    final events = await localDataSource.getSavedEvents();
    final index = events.indexWhere((e) => e.id == eventId);

    if (index != -1) {
      final event = events[index];
      event.isJoined.value = false;
      // event.availableSpots.value += 1;
      event.availableSpots.value = updatedEvent.availableSpots.value;
      await localDataSource.saveEvents(events);
      logInfo('Usuario se desunió del evento: $eventId');
    }
    return events[index];
  }

  @override
  Future<void> addRating(String eventId, double rating) async {
    try {
      // 1) Llamo al remoto y recibo la lista de ratings actualizada
      final updatedRatings = await remoteDataSource.addRating(eventId, rating);

      // 2) Cargo todos los eventos guardados
      final events = await localDataSource.getSavedEvents();
      final idx = events.indexWhere((e) => e.id == eventId);

      if (idx != -1) {
        // 3) Reemplazo la lista de ratings local por la que vino del servidor
        events[idx].ratings
          ..clear()
          ..addAll(updatedRatings);

        // 4) Recalculo el promedio
        events[idx].updateAverageRating();

        // 5) Persisto en Hive
        await localDataSource.saveEvents(events);

        logInfo('Feedback registrado en evento $eventId: $rating');
      }
    } catch (e) {
      logError('Error al enviar rating al backend: $e');
      rethrow; // opcional, para que el controlador sepa que falló
    }
  }



  @override
  Future<void> saveEvents(List<Event> events) async {
    await localDataSource.saveEvents(events.cast<EventModel>());
  }


  @override
Future<void> addComment(String eventId, String comment) async {
  // 1) Llama al remote y recibe la lista actualizada
  final updatedComments = await remoteDataSource.addComment(eventId, comment);

  // 2) Carga todos los eventos de Hive
  final events = await localDataSource.getSavedEvents();
  final idx = events.indexWhere((e) => e.id == eventId);

  if (idx != -1) {
    // 3) Reemplaza la lista de comments
    events[idx].comments
      ..clear()
      ..addAll(updatedComments);

    // 4) Guarda en Hive
    await localDataSource.saveEvents(events);
    logInfo('Comentario registrado en evento $eventId');
  }
}

}
