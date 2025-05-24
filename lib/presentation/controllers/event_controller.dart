import 'package:f_project_1/data/usescases_impl/check_event_version_usecase_impl.dart';
import 'package:f_project_1/domain/usecases/add_comment.dart';
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
  final AddComment _addCommentUseCase;

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
    required AddComment addCommentUseCase,
  })  : _repository = repository,
        _joinEventUseCase = joinEventUseCase,
        _unjoinEventUseCase = unjoinEventUseCase,
        _filterEventsUseCase = filterEventsUseCase,
        _checkVersionUseCase = checkVersionUseCase,
         _addCommentUseCase   = addCommentUseCase;
        

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
      try {
        // 1) Llamo al use case y recibo el EventModel actualizado
        final updated = await _joinEventUseCase(event.id);

        // 2) Actualizo sólo ese objeto en mi lista Rx
        event.availableSpots.value = updated.availableSpots.value;
        event.isJoined.value = true;

        //3) Persisto en Hive la lista modificada
        await _repository.saveEvents(filteredEvents);

        // 4) Actualizo la lista de joinedEvents para la UI
        updateJoinedEvents();

        Get.snackbar('¡Listo!', 'Te has inscrito correctamente.');
      } catch (e) {
        logError('Error en joinEvent: $e');
        Get.snackbar('Error', 'No se pudo suscribir al evento.');
      }
    }
  }

  Future<void> unjoinEvent(EventModel event) async {
    if (event.isJoined.value) {
      try {
        // 1) Llamo al use case que suma spots en el backend
        final updated = await _unjoinEventUseCase(event.id);

        event.availableSpots.value = updated.availableSpots.value;
        event.isJoined.value = false;
        await _repository.saveEvents(filteredEvents);
        updateJoinedEvents();

        Get.snackbar('Listo', 'Te has dado de baja del evento.');
      } catch (e) {
        logError('Error en unjoinEvent: $e');
        Get.snackbar('Error', 'No se pudo cancelar la suscripción.');
      }
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

  Future<void> addFeedback(EventModel event, double rating) async {
    try {
      // 1) Envía al backend + guarda en Hive
      await _repository.addRating(event.id, rating);

      // 2) Recupera de Hive (vía getAllEvents) y castéalo a EventModel
      final allEvents = await _repository.getAllEvents();
      final updatedEvent = allEvents
          .cast<EventModel>() // ← aquí el cast
          .firstWhere((e) => e.id == event.id);

      // 3) Sustituye la lista de ratings en memoria
      event.ratings
        ..clear()
        ..addAll(updatedEvent.ratings);
      event.updateAverageRating();

      Get.snackbar(
        '¡Gracias!',
        'Tu valoración ha sido registrada.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      logError('Error en addFeedback: $e');
      Get.snackbar(
        'Error',
        'No se pudo enviar tu valoración.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> addComment(EventModel event, String comment) async {
    try {
      await _addCommentUseCase(event.id, comment);

      // Actualiza en memoria la lista de comentarios
      final updated = (await _repository.getAllEvents())
          .cast<EventModel>()
          .firstWhere((e) => e.id == event.id);

      event.comments
        ..clear()
        ..addAll(updated.comments);

      Get.snackbar('¡Gracias!', 'Comentario agregado.',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'No se pudo enviar el comentario.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
