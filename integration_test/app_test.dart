// Importaciones necesarias para controladores, UI, test, dependencias y almacenamiento local.
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

// Implementación de un fake remoto para pruebas de integración sin usar la red real.
class FakeRemoteDataSource
    implements IEventRemoteDataSource, IVersionRemoteDataSource {
  // Lista de eventos simulados
  final List<EventModel> _remoteEvents = [
    EventModel(
      id: "1",
      title: "The Things We Wish We’d Learned Sooner",
      location: "Reflection Room",
      details: "Why is it so hard to talk about intimacy...",
      participants: 40,
      availableSpots: 18,
      date: "2025-12-10",
      path: "lib/assets/unbound01.jpeg",
      type: "Unbound",
    ),
    EventModel(
      id: "2",
      title: "Consent Isn’t Just a Word: Rethinking Connection",
      location: "Youth Circle Room",
      details: "More than a rule — consent is about understanding...",
      participants: 50,
      availableSpots: 27,
      date: "2025-12-10",
      path: "lib/assets/unbound02.png",
      type: "Unbound",
    ),
    EventModel(
      id: "99",
      title: 'Reclaiming Touch: Consent, Culture, and Connection',
      location: 'Wellness Studio A',
      details: "Explore how physical connection intersects with culture...",
      participants: 10,
      date: 'May 01, 2023, 5:00 PM',
      availableSpots: 10,
      path: 'lib/assets/unbound01.jpeg',
      type: 'Unbound',
    ),
  ];

  // Almacena retroalimentación de los usuarios por id de evento
  final Map<String, Map<String, dynamic>> _feedbacks = {};
  // Eventos a los que ya está unido el usuario (por defecto, al 99)
  final Set<String> _subscribedEvents = {"99"};
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
  Future<void> subscribeToEvent(String id) async {
    _subscribedEvents.add(id);
  }

  @override
  Future<void> sendFeedback(String id, int rating, String comment) async {
    _feedbacks[id] = {'rating': rating, 'comment': comment};
  }

  @override
  Future<int> fetchEventVersion() async => _remoteVersion;

  @override
  Future<int> fetchRemoteVersion() async => _remoteVersion;

  bool hasFeedbackFor(String id) => _feedbacks.containsKey(id);
  bool isSubscribed(String id) => _subscribedEvents.contains(id);
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

    final nameInput = find.byKey(const Key('name_input'));
    await tester.pumpAndSettle();
    expect(nameInput, findsOneWidget);
    await tester.enterText(nameInput, 'Juan');
    await tester.tap(find.byKey(const Key('start_button')));
    await tester.pumpAndSettle();

    final eventCard = find.byKey(const Key('eventCard_1'));
    expect(eventCard, findsOneWidget);
    final eventCard2 = find.byKey(const Key('eventCard_2'));
    expect(eventCard2, findsOneWidget);
    await tester.tap(eventCard);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byKey(const Key('joinButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('joinButton')));
    await tester.pumpAndSettle();

    final selected = Get.find<EventController>().selectedEvent.value!;
    expect(selected.isJoined.value, isTrue);

    await tester.tap(find.byKey(const Key('myEventsTab')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('eventCard_1')), findsOneWidget);

    final topNavController = Get.find<TopNavController>();
    topNavController.onTap(1);
    await tester.pumpAndSettle();

    final pastCard = find.byKey(const Key('pastEventCard_99'));
    expect(pastCard, findsOneWidget);
    await tester.tap(pastCard);
    await tester.pumpAndSettle();

    final fourthStar = find.byType(IconButton).at(3);
    await tester.tap(fourthStar);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('feedbackField')), 'Buen evento');
    await tester.tap(find.byKey(const Key('submitFeedbackButton')));
    await tester.pump();

    expect(find.text('Thanks!'), findsOneWidget);
    expect(find.text('Your rating has been recorded.'), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.byKey(const Key('profileTab')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('logoutButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('name_input')), findsOneWidget);

    await Hive.close();
  });
}
