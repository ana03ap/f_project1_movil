import 'package:f_project_1/data/events_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_project_1/presentation/pages/profile.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

// Test controller for Home
class TestHomeController extends HomeController {
  @override
  // ignore: overridden_fields
  final RxString name = 'Test User'.obs;
}
// Test controller for Events
class TestEventController extends EventController {
  @override
  // ignore: overridden_fields
  final RxList<Event> joinedEvents = <Event>[].obs;

  void addTestEvents(List<Event> events) {
    joinedEvents.addAll(events);
  }
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
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestableWidget(Widget child,
      {AdaptiveThemeMode initialMode = AdaptiveThemeMode.dark}) {
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
    expect(find.text('Test User'), findsOneWidget);
  });

  testWidgets('Displays event counter correctly (0 events)', (tester) async {
    await tester.pumpWidget(buildTestableWidget(MyProfile()));
    expect(find.text('You have subscribed to 0 events!'), findsOneWidget);
  });

  testWidgets('Displays event counter correctly (multiple events)', (tester) async {
    testEventController.joinedEvents.addAll([
      Event(
        id: 1,
        title: 'Test Event 1',
        location: 'Location 1',
        details: 'Details',
        availableSpots: 10,
        participants: 20,
        date: '2023-06-01',
        path: 'test',
        type: 'Test',
        isJoined: true,
      ),
      Event(
        id: 2,
        title: 'Test Event 2',
        location: 'Location 2',
        details: 'Details',
        availableSpots: 8,
        participants: 10,
        date: '2023-06-02',
        path: 'test',
        type: 'Test',
        isJoined: true,
      ),
    ]);

    await tester.pumpWidget(buildTestableWidget(MyProfile()));
    expect(find.text('You have subscribed to 2 events!'), findsOneWidget);
  });

  testWidgets('Dark mode switch reflects the current theme', (tester) async {
    await tester.pumpWidget(buildTestableWidget(MyProfile()));
    final switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, true);
  });

  testWidgets('Toggles theme when switch is tapped', (tester) async {
    await tester.pumpWidget(buildTestableWidget(MyProfile()));
    final switchFinder = find.byType(Switch);
    await tester.tap(switchFinder);
    await tester.pump();
    expect(tester.widget<Switch>(switchFinder).value, false);
  });

  testWidgets('Navigates to home when "Change name" is pressed', (tester) async {
    await tester.pumpWidget(
      buildTestableWidget(
        GetMaterialApp(
          initialRoute: '/profile',
          getPages: [
            GetPage(name: '/profile', page: () => MyProfile()),
            GetPage(
              name: '/home',
              page: () => const Scaffold(body: Center(child: Text('Home Screen'))),
            )
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('changeNameTile')));
    await tester.pumpAndSettle();

    expect(find.text('Home Screen'), findsOneWidget);
  });
}
