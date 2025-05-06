import 'package:f_project_1/presentation/controllers/connectivity_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:f_project_1/main.dart';
import 'package:f_project_1/data/models/event_hive_model.dart';
import 'package:f_project_1/data/datasources/local/event_local_data_source.dart';
import 'package:f_project_1/data/repositories/event_repository_impl.dart';
import 'package:f_project_1/core/network/network_info.dart';
import 'package:f_project_1/data/usescases_impl/check_event_version_usecase_impl.dart';
import 'package:f_project_1/domain/usecases/filter_events.dart';
import 'package:f_project_1/domain/usecases/join_event.dart';
import 'package:f_project_1/domain/usecases/unjoin_event.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/controllers/top_nav_controller.dart';
import 'package:f_project_1/data/models/event_model.dart';
import 'package:f_project_1/domain/datasources/i_event_remote_data_source.dart';
import 'package:f_project_1/domain/datasources/i_version_remote_data_source.dart';

class FakeRemoteDataSource
    implements IEventRemoteDataSource, IVersionRemoteDataSource {
  final List<EventModel> _remoteEvents = [
    EventModel(
      id: 1,
      title: "The Things We Wish We’d Learned Sooner",
      location: "Reflection Room",
      details:
          "Why is it so hard to talk about intimacy, desire, or even basic information about our bodies? This session opens up a safe space to explore what we’re rarely taught — about respect, boundaries, pleasure, and honest communication.",
      participants: 40,
      availableSpots: 18,
      date: "2025-12-10",
      path: "lib/assets/unbound01.jpeg",
      type: "Unbound",
    ),
    EventModel(
      id: 2,
      title: "Consent Isn’t Just a Word: Rethinking Connection",
      location: "Youth Circle Room",
      details:
          "More than a rule — consent is about understanding, respect, and presence. This workshop invites us to reflect on the messages we’ve received (or not} and how to build healthier dynamics through active listening and mutual care.",
      participants: 50,
      availableSpots: 27,
      date: "2025-12-10",
      path: "lib/assets/unbound02.png",
      type: "Unbound",
    ),
    EventModel(
      id: 99,
      title: 'Reclaiming Touch: Consent, Culture, and Connection',
      location: 'Wellness Studio A',
      details:
          "Explore how physical connection intersects with culture, trauma, and trust. This session invites participants to reflect on their boundaries, learn the language of consent, and reimagine intimacy through mutual respect and understanding.",
      participants: 10,
      date: 'May 01, 2023, 5:00 PM',
      availableSpots: 10,
      path: 'lib/assets/unbound01.jpeg',
      type: 'Unbound',
    ),
  ];

  final Map<int, Map<String, dynamic>> _feedbacks = {};
  final Set<int> _subscribedEvents = {99}; // ya unido al evento 99
  final int _remoteVersion = 1;

  @override
  Future<List<EventModel>> fetchEvents() async {
    return _remoteEvents.map((e) {
      final joined = _subscribedEvents.contains(e.id);
      return EventModel(
        id: e.id,
        title: e.title,
        location: e.location,
        details: e.details,
        participants: e.participants,
        date: e.date,
        availableSpots: e.availableSpots.value,
        path: e.path,
        type: e.type,
        isJoined: joined,
      );
    }).toList();
  }

  @override
  Future<void> subscribeToEvent(int id) async {
    _subscribedEvents.add(id);
  }

  @override
  Future<void> sendFeedback(int id, int rating, String comment) async {
    _feedbacks[id] = {'rating': rating, 'comment': comment};
  }

  @override
  Future<int> fetchEventVersion() async => _remoteVersion;

  @override
  Future<int> fetchRemoteVersion() async => _remoteVersion;

  bool hasFeedbackFor(int id) => _feedbacks.containsKey(id);
  bool isSubscribed(int id) => _subscribedEvents.contains(id);
}

class FakeNetworkInfo implements NetworkInfo {
  @override
  Future<bool> isConnected() async => true;

  @override
  Stream<bool> get stream => Stream.value(true);

  @override
  void openStream() {}
}

late FakeRemoteDataSource remoteDataSource;

Future<Widget> createTestApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(EventHiveModelAdapter());

  if (!Hive.isBoxOpen('eventsBox')) {
    await Hive.openBox<EventHiveModel>('eventsBox');
  }

  SharedPreferences.setMockInitialValues({});
  await SharedPreferences.getInstance();

  final localDataSource = EventLocalDataSource();
  remoteDataSource = FakeRemoteDataSource();

  Get.reset();
  Get.put<NetworkInfo>(FakeNetworkInfo());
  Get.put(ConnectivityController());

  final repo = EventRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
    networkInfo: Get.find<NetworkInfo>(),
  );

  final checkVersionUseCase = CheckEventVersionUseCaseImpl(
    local: localDataSource,
    remote: remoteDataSource,
  );

  final joinEventUseCase = JoinEvent(repo);
  final unjoinEventUseCase = UnjoinEvent(repo);
  final filterEventsUseCase = FilterEvents();

  Get.put(HomeController());
  Get.put(BottomNavController());
  Get.put(TopNavController());
  Get.put(EventController(
    repository: repo,
    joinEventUseCase: joinEventUseCase,
    unjoinEventUseCase: unjoinEventUseCase,
    filterEventsUseCase: filterEventsUseCase,
    checkVersionUseCase: checkVersionUseCase,
  ));

  return const MyApp(initialRoute: '/home');
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test de integración', (tester) async {
    final app = await createTestApp();
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    // HOME
    final nameInput = find.byKey(const Key('name_input'));
    await tester.pumpAndSettle();
    expect(nameInput, findsOneWidget);
    await tester.enterText(nameInput, 'Juan');
    await tester.tap(find.byKey(const Key('start_button')));
    await tester.pumpAndSettle();

    // EVENTOS
    final eventCard = find.byKey(const Key('eventCard_1'));
    expect(eventCard, findsOneWidget);
    final eventCard2 = find.byKey(const Key('eventCard_2'));
    expect(eventCard2, findsOneWidget);
    await tester.tap(eventCard);
    await tester.pumpAndSettle();

    // JOIN EVENTO FUTURO
    await tester.ensureVisible(find.byKey(const Key('joinButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('joinButton')));
    await tester.pumpAndSettle();

    // VALIDACIÓN ESTADO LOCAL (no remoto)
    final selected = Get.find<EventController>().selectedEvent.value!;
    expect(selected.isJoined.value, isTrue);

    // MIS EVENTOS (upcoming por defecto)
    await tester.tap(find.byKey(const Key('myEventsTab')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('eventCard_1')), findsOneWidget);

    // Cambiar el índice del TopNavController a "1" (Past Events)
    final topNavController = Get.find<TopNavController>();
    topNavController.onTap(1);
    await tester.pumpAndSettle();

    // FEEDBACK al evento 99
    final pastCard = find.byKey(const Key('pastEventCard_99'));
    expect(pastCard, findsOneWidget);
    await tester.tap(pastCard);
    await tester.pumpAndSettle();

    // Seleccionar rating
    final fourthStar = find.byType(IconButton).at(3); // cuarta estrella
    await tester.tap(fourthStar);
    await tester.pumpAndSettle();

    // Escribir comentario
    await tester.enterText(
        find.byKey(const Key('feedbackField')), 'Buen evento');
    await tester.tap(find.byKey(const Key('submitFeedbackButton')));
    await tester.pump(); // inicia la animación del snackbar

    // Verificar que el snackbar se muestra
    expect(find.text('Thanks!'), findsOneWidget);
    expect(find.text('Your rating has been recorded.'), findsOneWidget);

    // Esperar a que desaparezca
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // PERFIL → LOGOUT
    await tester.tap(find.byKey(const Key('profileTab')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('logoutButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('name_input')), findsOneWidget);

    await Hive.close();
  });
}
