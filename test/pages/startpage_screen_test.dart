import 'package:f_project_1/data/models/event_model.dart';
import 'package:f_project_1/domain/repositories/i_event_repository.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/pages/startpage.dart';
import 'package:f_project_1/presentation/widgets/event_card.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

// Mock repository sin lógica real
class FakeEventRepository implements EventRepository {
  @override
  Future<List<EventModel>> getAllEvents() async => [
        EventModel(
          id: 1,
          title: 'Event A',
          location: 'Room 1',
          details: 'Details A',
          participants: 30,
          availableSpots: 10,
          date: 'April 25, 2025, 10:00 AM',
          path: 'lib/assets/unbound01.jpeg',
          type: 'Unbound',
        ),
        EventModel(
          id: 2,
          title: 'Event B',
          location: 'Room 2',
          details: 'Details B',
          participants: 40,
          availableSpots: 5,
          date: 'April 25, 2025, 12:00 PM',
          path: 'lib/assets/education01.png',
          type: 'education',
        ),
        EventModel(
          id: 3,
          title: 'Event C',
          location: 'Room 3',
          details: 'Details C',
          participants: 20,
          availableSpots: 15,
          date: 'April 25, 2025, 3:00 PM',
          path: 'lib/assets/unbound02.png',
          type: 'Unbound',
        ),
      ];

  @override
  Future<void> addRating(int eventId, double rating) async {}

  @override
  Future<void> joinEvent(int eventId) async {}

  @override
  Future<void> unjoinEvent(int eventId) async {}
}

void main() {
  testWidgets('StartPage filtering works correctly', (WidgetTester tester) async {
    Get.reset();

    final fakeRepo = FakeEventRepository();

    final controller = Get.put(
      EventController(repository: fakeRepo),
    );

    Get.put(HomeController());
    Get.put(BottomNavController());

    // Cargar eventos manualmente en el controlador
    final events = await fakeRepo.getAllEvents();
    controller.filteredEvents.assignAll(events);

    await tester.pumpWidget(
      GetMaterialApp(
        home: Startpage(),
      ),
    );

    await tester.pumpAndSettle();

    // Deben aparecer todos los eventos (3)
    expect(find.byType(EventCard), findsNWidgets(3));

    // Tocar el filtro "Unbound"
    await tester.tap(find.text('Unbound'));
    await tester.pumpAndSettle();

    // Ahora deben aparecer solo los eventos tipo "Unbound"
    expect(find.byType(EventCard), findsNWidgets(2));
  });
}
