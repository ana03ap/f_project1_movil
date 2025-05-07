import 'package:f_project_1/data/models/event_model.dart';
import 'package:f_project_1/domain/repositories/i_event_repository.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
/*
// Mock simple sin Hive ni plugins nativos
class FakeEventRepository implements EventRepository {
  @override
  Future<List<EventModel>> getAllEvents() async => [];

  @override
  Future<void> addRating(int eventId, double rating) async {}

  @override
  Future<void> joinEvent(int eventId) async {}

  @override
  Future<void> unjoinEvent(int eventId) async {}
}

void main() {
  late EventController controller;
  late EventModel testEvent;

  setUp(() {
    Get.reset();

    controller = Get.put(EventController(repository: FakeEventRepository()));

    testEvent = EventModel(
      id: 1,
      title: 'Test Event',
      location: 'Test Hall',
      details: 'Some test description.',
      participants: 100,
      availableSpots: 25,
      date: 'April 30, 2025, 5:00 PM',
      path: 'lib/assets/test.jpg',
      type: 'education',
    );
  });

  tearDown(() {
    Get.reset();
  });

  test('Should display all event information correctly', () {
    expect(testEvent.title.isNotEmpty, true);
    expect(testEvent.location.isNotEmpty, true);
    expect(testEvent.details.isNotEmpty, true);
    expect(testEvent.date.isNotEmpty, true);
    expect(testEvent.path.isNotEmpty, true);
    expect(testEvent.type.isNotEmpty, true);
    expect(testEvent.participants, isA<int>());
    expect(testEvent.availableSpots.value, isA<int>());
  });

  test('Should join an event and update fields', () async {
    expect(testEvent.isJoined.value, false);
    final initialSpots = testEvent.availableSpots.value;

    await controller.joinEvent(testEvent);

    expect(testEvent.isJoined.value, true);
    expect(testEvent.availableSpots.value, initialSpots - 1);
    expect(controller.joinedEvents.contains(testEvent), true);
  });

  test('Should unjoin an event and restore fields', () async {
    await controller.joinEvent(testEvent);
    final afterJoinSpots = testEvent.availableSpots.value;

    await controller.unjoinEvent(testEvent);

    expect(testEvent.isJoined.value, false);
    expect(testEvent.availableSpots.value, afterJoinSpots + 1);
    expect(controller.joinedEvents.contains(testEvent), false);
  });
}
*/