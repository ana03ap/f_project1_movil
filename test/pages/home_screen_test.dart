import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:f_project_1/presentation/pages/home_screen.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';


class MockHomeController extends Mock implements HomeController {
  @override
  InternalFinalCallback<void> get onStart =>
      InternalFinalCallback<void>(callback: () {});
}

void main() {
  late MockHomeController mockController;


  setUp(() {
    mockController = MockHomeController();
    Get.reset(); 
    Get.put<HomeController>(mockController); 
  });

  testWidgets('Displays the main widgets', (WidgetTester tester) async {
    // Carga la pantalla HomeScreen
    await tester.pumpWidget(GetMaterialApp(home: HomeScreen()));


    expect(find.text('Enter Your Name'), findsOneWidget); 
    expect(find.byType(TextField), findsOneWidget); 
    expect(find.text('Start'), findsOneWidget); 
  });

  testWidgets('Calls setName when typing into the TextField',
      (WidgetTester tester) async {

    await tester.pumpWidget(GetMaterialApp(home: HomeScreen()));


    final textField = find.byType(TextField);
    await tester.enterText(textField, 'Emily');

    verify(mockController.setName('Emily')).called(1);
  });

  testWidgets('Shows snackbar if no name is provided', (WidgetTester tester) async {

    await tester.pumpWidget(
      GetMaterialApp(
        home: HomeScreen(),
      ),
    );


    await tester.tap(find.text('Start'));
    await tester.pump();


    expect(find.text('Please enter your name.'), findsOneWidget);


    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('Navigates to /startpage when a name is provided',
      (WidgetTester tester) async {

    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => HomeScreen()),
          GetPage(name: '/startpage', page: () => const Startpage()), 
        ],
      ),
    );


    final textField = find.byType(TextField);
    await tester.enterText(textField, 'Emily');


    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle(); 

    verify(mockController.setName('Emily')).called(2);
    expect(find.byType(Startpage), findsOneWidget); 
  });
}


class Startpage extends StatelessWidget {
  const Startpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Start Page!'),
      ),
    );
  }
}