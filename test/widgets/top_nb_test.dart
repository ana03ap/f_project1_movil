import 'package:f_project_1/presentation/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_project_1/presentation/controllers/top_nav_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TopNavBar Widget Tests', () {
    late TopNavController controller;

    setUp(() {
      Get.testMode = true;
      controller = TopNavController();
      Get.put<TopNavController>(controller);
    });

    tearDown(() => Get.reset());

    testWidgets('renders both tabs and updates color on tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: TopNavBar(),
          ),
        ),
      );

      expect(find.text('Upcoming Events'), findsOneWidget);
      expect(find.text('Past Events'), findsOneWidget);

      Text upcomingText = tester.widget<Text>(find.text('Upcoming Events'));
      Text pastText = tester.widget<Text>(find.text('Past Events'));

      expect(upcomingText.style?.color, Colors.purple);
      expect(pastText.style?.color, Colors.grey);

      await tester.tap(find.text('Past Events'));
      await tester.pump();

      upcomingText = tester.widget<Text>(find.text('Upcoming Events'));
      pastText = tester.widget<Text>(find.text('Past Events'));

      expect(upcomingText.style?.color, Colors.grey);
      expect(pastText.style?.color, Colors.purple);

      expect(controller.currentIndex.value, 1);
    });
  });
}
