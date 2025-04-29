import 'package:f_project_1/data/datasources/hive/hive_event_source.dart';
import 'package:f_project_1/data/datasources/remote_data_source.dart';
import 'package:f_project_1/data/datasources/event_version_manager.dart';
import 'package:f_project_1/domain/repositories/event_repository_impl.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../data/models/event_model.dart';
import '../../domain/usecases/join_event.dart';
import '../../domain/usecases/unjoin_event.dart';
import '../../domain/usecases/filter_events.dart';
import '../../domain/repositories/event_repository.dart';

class EventController extends GetxController {
  final EventRepository _repository = EventRepositoryImpl();
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
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // CARGA INTELIGENTE DE EVENTOS CON VERSION CHECK
  Future<void> loadEventsFromLocalStorage() async {
    final hasInternet = await hasInternetConnection();
    final eventosLocales = await hiveSource.loadEvents();

    if (hasInternet) {
      try {
        final remoteVersion = await _versionManager.fetchRemoteVersion();
        final localVersion = await _versionManager.getLocalVersion();

        if (remoteVersion > localVersion) {
          final fetchedEvents = await _remoteDataSource.fetchEvents();
          filteredEvents.value = fetchedEvents;
          await hiveSource.saveEvents(fetchedEvents);
          await _versionManager.setLocalVersion(remoteVersion);
          print('✅ Nueva versión detectada: eventos actualizados');
        } else {
          if (eventosLocales.isNotEmpty) {
            filteredEvents.value = eventosLocales;
            print('✅ Versión actual, usando eventos locales');
          } else {
            final mockEvents = _repository.getAllEvents().cast<EventModel>();
            filteredEvents.value = mockEvents;
            await hiveSource.saveEvents(mockEvents);
            print('✅ No datos locales, usando mocks');
          }
        }
      } catch (e) {
        print('⚠️ Error checking version or fetching events: $e');
        if (eventosLocales.isNotEmpty) {
          filteredEvents.value = eventosLocales;
          print('✅ Usando eventos locales por error en API');
        } else {
          final mockEvents = _repository.getAllEvents().cast<EventModel>();
          filteredEvents.value = mockEvents;
          await hiveSource.saveEvents(mockEvents);
          print('✅ Error total, usando mocks');
        }
      }
    } else {
      if (eventosLocales.isNotEmpty) {
        filteredEvents.value = eventosLocales;
        print('✅ Sin internet, usando eventos locales');
      } else {
        final mockEvents = _repository.getAllEvents().cast<EventModel>();
        filteredEvents.value = mockEvents;
        await hiveSource.saveEvents(mockEvents);
        print('✅ Sin internet ni datos locales, usando mocks');
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
      base = _repository.getAllEvents().cast<EventModel>();
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
