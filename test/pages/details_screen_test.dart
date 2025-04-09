import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/data/events_data.dart'; 

void main() {
  late EventController controller;
  late Event testEvent;

  setUp(() {
    controller = Get.put(EventController());
    testEvent = eventsList.first;
    controller.resetFilter();
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

  test('Should join an event and update fields', () {
    expect(testEvent.isJoined.value, false);
    final initialSpots = testEvent.availableSpots.value;

    controller.joinEvent(testEvent);

    expect(testEvent.isJoined.value, true);
    expect(testEvent.availableSpots.value, initialSpots - 1);
    expect(controller.joinedEvents.contains(testEvent), true);
  });

  test('Should unjoin an event and restore fields', () {
    controller.joinEvent(testEvent);
    final afterJoinSpots = testEvent.availableSpots.value;

    controller.unjoinEvent(testEvent);

    expect(testEvent.isJoined.value, false);
    expect(testEvent.availableSpots.value, afterJoinSpots + 1);
    expect(controller.joinedEvents.contains(testEvent), false);
  });
}

