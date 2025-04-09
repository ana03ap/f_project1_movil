import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/pages/startpage.dart';
import 'package:f_project_1/presentation/widgets/event_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('StartPage filtering works correctly', (WidgetTester tester) async {

    Get.put(EventController());
    Get.put(HomeController());
    Get.put(BottomNavController());


    await tester.pumpWidget(
      GetMaterialApp(
        home: Startpage(),
      ),
    );

    await tester.pumpAndSettle();


    expect(find.byType(EventCard), findsWidgets);

    await tester.tap(find.text('Unbound'));
    await tester.pumpAndSettle();


    expect(find.byType(EventCard), findsNWidgets(2));
  });
}
