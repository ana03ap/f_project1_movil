import 'package:f_project_1/data/usescases_impl/check_event_version_usecase_impl.dart';
import 'package:f_project_1/presentation/controllers/connectivity_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

import '../../domain/repositories/i_event_repository.dart';
import '../../domain/usecases/join_event.dart';
import '../../domain/usecases/unjoin_event.dart';
import '../../domain/usecases/filter_events.dart';
import '../../domain/usecases/i_check_event_version_usecase.dart';

import '../../data/models/event_model.dart';

class EventController extends GetxController {
  final IEventRepository _repository;
  final JoinEvent _joinEventUseCase;
  final UnjoinEvent _unjoinEventUseCase;
  final FilterEvents _filterEventsUseCase;
  final ICheckEventVersionUseCase _checkVersionUseCase;

  final RxList<EventModel> filteredEvents = <EventModel>[].obs;
  final RxList<EventModel> joinedEvents = <EventModel>[].obs;
  final Rxn<EventModel> selectedEvent = Rxn<EventModel>();
  final RxString selectedFilter = ''.obs;

  EventController({
    required IEventRepository repository,
    required JoinEvent joinEventUseCase,
    required UnjoinEvent unjoinEventUseCase,
    required FilterEvents filterEventsUseCase,
    required ICheckEventVersionUseCase checkVersionUseCase,
  })  : _repository = repository,
        _joinEventUseCase = joinEventUseCase,
        _unjoinEventUseCase = unjoinEventUseCase,
        _filterEventsUseCase = filterEventsUseCase,
        _checkVersionUseCase = checkVersionUseCase;

  @override
  void onInit() {
    super.onInit();
    resetFilter();
    loadEventsIntelligently();
  }

  Future<void> loadEventsIntelligently() async {
    final connected = Get.find<ConnectivityController>().connection;

    try {
      final hasNewVersion =
          connected ? await _checkVersionUseCase.hasNewVersion() : false;

      if (hasNewVersion) {
        logInfo('Nueva versión detectada, actualizando eventos...');
        final fetchedEvents = await _repository.getAllEvents();
        filteredEvents.value = fetchedEvents.cast<EventModel>();
        updateJoinedEvents();

        await _repository.saveEvents(filteredEvents);
        final remoteVersion =
            await (_checkVersionUseCase as CheckEventVersionUseCaseImpl)
                .remote
                .fetchRemoteVersion();
        await (_checkVersionUseCase).local.setLocalVersion(remoteVersion);
      }

      final events = await _repository.getAllEvents();
      filteredEvents.value = events.cast<EventModel>();
      updateJoinedEvents();
    } catch (e) {
      logError('Error al cargar eventos: $e');
    }
  }

  void selectEvent(EventModel event) {
    selectedEvent.value = event;
  }

  void toggleJoinEvent(EventModel event) {
    event.isJoined.value ? unjoinEvent(event) : joinEvent(event);
  }


Future<void> joinEvent(EventModel event) async {
  if (!event.isJoined.value && event.availableSpots.value > 0) {

    event.isJoined.value = true;
    event.availableSpots.value--;

    final allEvents = await _repository.getAllEvents();

    final index = allEvents.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      allEvents[index] = event;
    }


    await _repository.saveEvents(allEvents);

    updateJoinedEvents();
  }
}

Future<void> unjoinEvent(EventModel event) async {
  if (event.isJoined.value) {
    event.isJoined.value = false;
    event.availableSpots.value++;

    final allEvents = await _repository.getAllEvents();

    final index = allEvents.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      allEvents[index] = event;
    }

    await _repository.saveEvents(allEvents);

    updateJoinedEvents();
  }
}



  void updateJoinedEvents() {
    joinedEvents.value = filteredEvents.where((e) => e.isJoined.value).toList();
  }

  void filterEvents(String type) {
    selectedFilter.value = type;
    updateFilteredEvents();
  }

  void resetFilter() {
    selectedFilter.value = '';
    updateFilteredEvents();
  }

  Future<void> updateFilteredEvents() async {
    final base = await _repository.getAllEvents();
    final filtered = _filterEventsUseCase(selectedFilter.value, base);
    filteredEvents.assignAll(filtered.cast<EventModel>());
  }

  bool isEventFuture(String dateString) {
    try {
      final format = DateFormat("MMMM dd, yyyy, h:mm a", "en_US");
      final eventDate = format.parse(dateString, true).toLocal();
      return eventDate.isAfter(DateTime.now().toLocal());
    } catch (e) {
      logError('⚠️ Error parsing date: $dateString');
      return true;
    }
  }

  List<EventModel> get upcomingEvents =>
      filteredEvents.where((event) => isEventFuture(event.date)).toList();

  List<EventModel> get myUpcomingEvents => filteredEvents
      .where((e) => e.isJoined.value && isEventFuture(e.date))
      .toList();

  List<EventModel> get myPastEvents => filteredEvents
      .where((e) => e.isJoined.value && !isEventFuture(e.date))
      .toList();

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

