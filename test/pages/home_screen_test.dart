// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:f_project_1/presentation/controllers/home_controller.dart';
// import 'package:f_project_1/presentation/pages/home_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   late HomeController homeController;

//   setUp(() {
//     homeController = HomeController();
//     Get.put(homeController);
//   });

//   testWidgets('HomeScreen navega si el nombre no está vacío', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: HomeScreen()));

//     // Ingresa nombre
//     await tester.enterText(find.byType(TextField), 'Ana');
//     await tester.tap(find.text('Start'));
//     await tester.pump();

//     // Verifica que el nombre se guardó
//     expect(homeController.name.value, 'Ana');
//     // Verifica navegación (mockeando Get.toNamed)
//   });
// }