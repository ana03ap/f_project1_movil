import 'dart:ui';

import 'package:f_project_1/data/datasources/local/hive_event_source.dart';
import 'package:f_project_1/data/datasources/remote/remote_data_source.dart';
import 'package:f_project_1/data/datasources/local/event_version_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../data/models/event_model.dart';
import '../../domain/usecases/join_event.dart';
import '../../domain/usecases/unjoin_event.dart';
import '../../domain/usecases/filter_events.dart';
import '../../domain/repositories/event_repository.dart';
import 'dart:io';


class EventController extends GetxController {
  final EventRepository _repository;

  EventController({required EventRepository repository})
      : _repository = repository;

  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final EventVersionManager _versionManager = EventVersionManager();
  final hiveSource = HiveEventSource();

  final RxList<EventModel> joinedEvents = <EventModel>[].obs;
  final RxList<EventModel> filteredEvents = <EventModel>[].obs;
  final Rxn<EventModel> selectedEvent = Rxn<EventModel>();
  final RxString selectedFilter = ''.obs;

  final JoinEvent _joinEventUseCase = JoinEvent();
  final UnjoinEvent _unjoinEventUseCase = UnjoinEvent();
  final FilterEvents _filterEventsUseCase = FilterEvents();

  @override
  void onInit() {
    super.onInit();
    resetFilter();
    loadEventsFromLocalStorage();
  }

  // CONECTIVIDAD
Future<bool> hasInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}


// CARGA INTELIGENTE DE EVENTOS CON VERSION CHECK
Future<void> loadEventsFromLocalStorage() async {
  final hasInternet = await hasInternetConnection();
  final eventosLocales = await hiveSource.loadEvents();

  if (hasInternet) {
    try {
      final remoteVersion = await _versionManager.fetchRemoteVersion();
      final localVersion = await _versionManager.getLocalVersion();

      if (remoteVersion > localVersion || eventosLocales.isEmpty) {
        final fetchedEvents = await _remoteDataSource.fetchEvents();

        if (fetchedEvents.isEmpty) {
          Get.snackbar(
            'Eventos no encontrados',
            'La API respondió pero no envió ningún evento.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFd32f2f),
            colorText: const Color(0xFFFFFFFF),
          );
        } else {
          Get.snackbar(
            'Eventos cargados',
            'Se cargaron ${fetchedEvents.length} eventos desde la API.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF388e3c),
            colorText: const Color(0xFFFFFFFF),
          );
        }

        filteredEvents.value = fetchedEvents;
        updateJoinedEvents();
        await hiveSource.saveEvents(fetchedEvents);
        await _versionManager.setLocalVersion(remoteVersion);
      } else {
        filteredEvents.value = eventosLocales;
        updateJoinedEvents();
        print('✅ Versión actual, usando eventos locales');
      }
    } catch (e) {
      Get.snackbar(
        'Error de conexión',
        'No se pudo conectar con la API:\n$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFd32f2f),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 6),
      );

      if (eventosLocales.isNotEmpty) {
        filteredEvents.value = eventosLocales;
        updateJoinedEvents();
        print('✅ Usando eventos locales por error');
      } else {
        final mockEvents = await _repository.getAllEvents();
        filteredEvents.value = mockEvents.cast<EventModel>();
        updateJoinedEvents();
        await hiveSource.saveEvents(mockEvents.cast<EventModel>());
        print('✅ Fallback total: usando eventos mock');
      }
    }
  } else {
    if (eventosLocales.isNotEmpty) {
      filteredEvents.value = eventosLocales;
      updateJoinedEvents();
      Get.snackbar(
        'Modo sin conexión',
        'Mostrando eventos almacenados localmente.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFfbc02d),
        colorText: const Color(0xFF000000),
      );
    } else {
      final mockEvents = await _repository.getAllEvents();
      filteredEvents.value = mockEvents.cast<EventModel>();
      updateJoinedEvents();
      await hiveSource.saveEvents(mockEvents.cast<EventModel>());
      Get.snackbar(
        'Sin conexión ni datos',
        'Se mostrarán eventos de prueba.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFd32f2f),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }
}



  // MANEJO DE EVENTOS
  void selectEvent(EventModel event) {
    selectedEvent.value = event;
  }

  void toggleJoinEvent(EventModel event) {
    if (event.isJoined.value) {
      unjoinEvent(event);
    } else {
      joinEvent(event);
    }
  }

  void updateJoinedEvents() {
  joinedEvents.value = filteredEvents.where((e) => e.isJoined.value).toList();
}


  Future<void> joinEvent(EventModel event) async {
    _joinEventUseCase(event);
    _repository.joinEvent(event.id);

    await hiveSource.saveEvents(filteredEvents);
    joinedEvents.value = filteredEvents.where((e) => e.isJoined.value).toList();

    updateFilteredEvents();
  }

  Future<void> unjoinEvent(EventModel event) async {
    _unjoinEventUseCase(event);
    _repository.unjoinEvent(event.id);

    await hiveSource.saveEvents(filteredEvents);
    joinedEvents.value = filteredEvents.where((e) => e.isJoined.value).toList();

    updateFilteredEvents();
  }

  // FILTRADO
  void filterEvents(String type) {
    selectedFilter.value = type;
    updateFilteredEvents();
  }

  void resetFilter() {
    selectedFilter.value = '';
    updateFilteredEvents();
  }

  Future<void> updateFilteredEvents() async {
    List<EventModel> base;

    if (hiveSource.hasCachedEvents()) {
      base = await hiveSource.loadEvents();
    } else {
      final events = await _repository.getAllEvents();
      base = events.map((e) => e as EventModel).toList();
    }

    final filtered = _filterEventsUseCase(selectedFilter.value, base);
    filteredEvents.assignAll(filtered);
  }

  // SIMULACIÓN DE FETCH NUEVOS EVENTOS
  Future<void> simulateFetchingNewEvents() async {
    final hasInternet = await hasInternetConnection();

    if (hasInternet) {
      try {
        final nuevosEventos = await _remoteDataSource.fetchEvents();
        filteredEvents.value = nuevosEventos;
        updateJoinedEvents();
        await hiveSource.saveEvents(nuevosEventos);
        final remoteVersion = await _versionManager.fetchRemoteVersion();
        await _versionManager.setLocalVersion(remoteVersion);
        print('✅ Nuevos eventos descargados y versión actualizada');
      } catch (e) {
        print('⚠️ Error fetching new events: $e');
      }
    } else {
      print('⚠️ No internet, no se pueden descargar nuevos eventos');
    }
  }

  // FECHAS
  bool isEventFuture(String dateString) {
    try {
      final format = DateFormat("MMMM dd, yyyy, h:mm a", "en_US");
      final eventDate = format.parse(dateString, true).toLocal();
      return eventDate.isAfter(DateTime.now().toLocal());
    } catch (e) {
      print('⚠️ Error parsing date: $dateString');
      return true;
    }
  }

  // UPCOMING EVENTS
  List<EventModel> get upcomingEvents {
    return filteredEvents.where((event) => isEventFuture(event.date)).toList();
  }

  // NUEVOS GETTERS

  List<EventModel> get myUpcomingEvents {
    return filteredEvents
        .where((e) => e.isJoined.value && isEventFuture(e.date))
        .toList();
  }

  List<EventModel> get myPastEvents {
    return filteredEvents
        .where((e) => e.isJoined.value && !isEventFuture(e.date))
        .toList();
  }

  // FEEDBACK
  void addFeedback(EventModel event, double rating) {
    event.ratings.add(rating);
    event.updateAverageRating();
    _repository.addRating(event.id, rating);

    Get.snackbar(
      'Thanks!',
      'Your rating has been recorded.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
