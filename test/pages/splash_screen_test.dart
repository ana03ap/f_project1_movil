import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_project_1/presentation/pages/splash_screen.dart';
import 'package:f_project_1/presentation/pages/home_screen.dart';

void main() {
  testWidgets('Splash navigates automatically to /home after 2 seconds',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/splash',
        getPages: [
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(name: '/home', page: () => HomeScreen()),
        ],
      ),
    );

    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
