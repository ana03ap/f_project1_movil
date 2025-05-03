import 'package:f_project_1/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_project_1/presentation/pages/profile.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:f_project_1/domain/repositories/event_repository.dart';

// Mock repository que no hace nada
class FakeEventRepository implements EventRepository {
  @override
  Future<List<EventModel>> getAllEvents() async => [];

  @override
  Future<void> joinEvent(int eventId) async {}

  @override
  Future<void> unjoinEvent(int eventId) async {}

  @override
  Future<void> addRating(int eventId, double rating) async {}
}

// Controlador de prueba que no depende de Hive/API
class TestEventController extends EventController {
  TestEventController() : super(repository: FakeEventRepository());

  @override
  // ignore: overridden_fields
  final RxList<EventModel> joinedEvents = <EventModel>[].obs;

  void addTestEvents(List<EventModel> events) {
    joinedEvents.addAll(events);
  }
}

class TestHomeController extends HomeController {
  @override
  final RxString name = 'Test User'.obs;
}

void main() {
  late TestHomeController testHomeController;
  late TestEventController testEventController;

  setUp(() {
    Get.reset();
    testHomeController = TestHomeController();
    testEventController = TestEventController();
    Get.put<HomeController>(testHomeController);
    Get.put<EventController>(testEventController);
    Get.put(BottomNavController());
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestableWidget(Widget child, {AdaptiveThemeMode initialMode = AdaptiveThemeMode.dark}) {
    return AdaptiveTheme(
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      initial: initialMode,
      builder: (light, dark) => GetMaterialApp(
        theme: light,
        darkTheme: dark,
        home: child,
      ),
    );
  }

  testWidgets('Displays user name correctly', (tester) async {
    await tester.pumpWidget(buildTestableWidget(MyProfile()));
    await tester.pumpAndSettle();
    expect(find.text('Test User'), findsOneWidget);
  });

  testWidgets('Displays event counter correctly (0 events)', (tester) async {
    await tester.pumpWidget(buildTestableWidget(MyProfile()));
    await tester.pumpAndSettle();
    expect(find.text('You have subscribed to 0 events!'), findsOneWidget);
  });

  testWidgets('Displays event counter correctly (multiple events)', (tester) async {
    testEventController.joinedEvents.addAll([
      EventModel(
        id: 1,
        title: 'Event 1',
        location: 'Place 1',
        details: 'Details 1',
        participants: 10,
        availableSpots: 5,
        date: 'April 20, 2025, 9:00 AM',
        path: 'test',
        type: 'test',
        isJoined: true,
      ),
      EventModel(
        id: 2,
        title: 'Event 2',
        location: 'Place 2',
        details: 'Details 2',
        participants: 12,
        availableSpots: 3,
        date: 'April 21, 2025, 10:00 AM',
        path: 'test',
        type: 'test',
        isJoined: true,
      ),
    ]);

    await tester.pumpWidget(buildTestableWidget(MyProfile()));
    await tester.pumpAndSettle();
    expect(find.text('You have subscribed to 2 events!'), findsOneWidget);
  });

  testWidgets('Dark mode switch reflects the current theme', (tester) async {
    await tester.pumpWidget(buildTestableWidget(MyProfile(), initialMode: AdaptiveThemeMode.dark));
    await tester.pumpAndSettle();
    final switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, true);
  });

  testWidgets('Toggles theme when switch is tapped', (tester) async {
    await tester.pumpWidget(buildTestableWidget(MyProfile(), initialMode: AdaptiveThemeMode.dark));
    await tester.pumpAndSettle();
    final switchFinder = find.byType(Switch);
    await tester.tap(switchFinder);
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(switchFinder).value, false);
  });

  testWidgets('Navigates to home when "Change name" is pressed', (tester) async {
    await tester.pumpWidget(
      AdaptiveTheme(
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        initial: AdaptiveThemeMode.dark,
        builder: (light, dark) => GetMaterialApp(
          theme: light,
          darkTheme: dark,
          initialRoute: '/profile',
          getPages: [
            GetPage(name: '/profile', page: () => MyProfile()),
            GetPage(name: '/home', page: () => const Scaffold(body: Text('Home Screen'))),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('changeNameTile')));
    await tester.pumpAndSettle();
    expect(find.text('Home Screen'), findsOneWidget);
  });
}
