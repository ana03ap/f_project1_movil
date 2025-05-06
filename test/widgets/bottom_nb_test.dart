import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/widgets/bottom_nav_bar.dart';

class FakeBottomNavController extends GetxController
    implements BottomNavController {
  int tappedIndex = -1;

  @override
  void onTap(int index) {
    tappedIndex = index;
  }

  @override
  int getCurrentIndex() => 0;
}

void main() {
  late FakeBottomNavController fakeController;

  setUp(() {
    Get.testMode = true;
    fakeController = FakeBottomNavController();
    Get.put<BottomNavController>(fakeController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('BottomNavBar shows items and calls onTap when tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomNavBar(),
        ),
      ),
    );

    expect(find.text('Events'), findsOneWidget);
    expect(find.text('My Events'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.event));
    await tester.pumpAndSettle();
    expect(fakeController.tappedIndex, 0);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    expect(fakeController.tappedIndex, 2);

    await tester.tap(find.byIcon(Icons.list));
    await tester.pumpAndSettle();

    expect(fakeController.tappedIndex, 1);
  });
}
