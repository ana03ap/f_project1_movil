import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/domain/repositories/event_repository_impl.dart';
import 'package:f_project_1/presentation/pages/feedback_screen.dart';

void main() {
  late EventController controller;

  setUp(() {
    Get.reset();
    controller = Get.put(EventController());
    Get.put(BottomNavController());

    final mockEvent = EventRepositoryImpl().getAllEvents().first as dynamic;
    controller.selectEvent(mockEvent);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Can press star and submit without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: FeedbackScreen(),
      ),
    );

    // Tap estrella 3 (rating 3)
    final thirdStar = find.byIcon(Icons.star).at(2);
    await tester.tap(thirdStar);
    await tester.pump();




  });
}
