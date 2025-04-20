import 'package:f_project_1/data/datasources/hive/hive_event_source.dart';
import 'package:f_project_1/domain/repositories/event_repository_impl.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/event_model.dart';
import '../../domain/usecases/join_event.dart';
import '../../domain/usecases/unjoin_event.dart';
import '../../domain/usecases/filter_events.dart';
import '../../domain/repositories/event_repository.dart';

class EventController extends GetxController {
  final EventRepository _repository = EventRepositoryImpl();

  final RxList<EventModel> joinedEvents = <EventModel>[].obs;
  final RxList<EventModel> filteredEvents = <EventModel>[].obs;
  final Rxn<EventModel> selectedEvent = Rxn<EventModel>();
  final RxString selectedFilter = ''.obs;

  final JoinEvent _joinEventUseCase = JoinEvent();
  final UnjoinEvent _unjoinEventUseCase = UnjoinEvent();
  final FilterEvents _filterEventsUseCase = FilterEvents();

  final hiveSource = HiveEventSource();
  @override
  void onInit() {
    super.onInit();
    resetFilter();
    loadEventsFromLocalStorage();
  }

//HIVE

  Future<void> loadEventsFromLocalStorage() async {
    final eventos = await hiveSource.loadEvents();

    if (eventos.isEmpty) {
      // Hive está vacío → usar mock
      final mockEvents = _repository.getAllEvents().cast<EventModel>();

      filteredEvents.value = mockEvents;
      await hiveSource.saveEvents(mockEvents);
    } else {
      // Hive tiene datos
      filteredEvents.value = eventos;
    }
  }

  Future<void> simulateFetchingNewEvents(List<EventModel> nuevosEventos) async {
    filteredEvents.value = nuevosEventos;
    await hiveSource.saveEvents(nuevosEventos);
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

  // void joinEvent(EventModel event) {
  //   _joinEventUseCase(event);
  //   _repository.joinEvent(event.id);

  //   if (!joinedEvents.any((e) => e.id == event.id)) {
  //     joinedEvents.add(event);
  //   }

  //   updateFilteredEvents();
  // }

  Future<void> joinEvent(EventModel event) async {
    _joinEventUseCase(event); // actualiza isJoined y availableSpots
    _repository.joinEvent(event.id); // (mock o log)

    // Guardar todos los eventos en Hive
    await hiveSource.saveEvents(filteredEvents);
    joinedEvents.value = filteredEvents.where((e) => e.isJoined.value).toList();

    updateFilteredEvents();
  }

  // void unjoinEvent(EventModel event) {
  //   _unjoinEventUseCase(event);
  //   _repository.unjoinEvent(event.id);

  //   joinedEvents.removeWhere((e) => e.id == event.id);
  //   updateFilteredEvents();
  // }

  Future<void> unjoinEvent(EventModel event) async {
    _unjoinEventUseCase(event); // revierte isJoined y availableSpots
    _repository.unjoinEvent(event.id); // (mock o log)

    // Guardar todos los eventos en Hive
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

  // void updateFilteredEvents() {
  //   final allEvents = _repository.getAllEvents().cast<EventModel>();
  //   final filtered = _filterEventsUseCase(selectedFilter.value, allEvents);
  //   filteredEvents.assignAll(filtered);
  // }
  Future<void> updateFilteredEvents() async {
    List<EventModel> base;

    if (hiveSource.hasCachedEvents()) {
      base = await hiveSource.loadEvents(); // Esperamos Hive
    } else {
      base = _repository.getAllEvents().cast<EventModel>();
    }

    final filtered = _filterEventsUseCase(selectedFilter.value, base);
    filteredEvents.assignAll(filtered);
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

//PARA LOS UPCOMING
  List<EventModel> get upcomingEvents {
    return filteredEvents.where((event) => isEventFuture(event.date)).toList();
  }

  //NUEVOS GETTERS

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
