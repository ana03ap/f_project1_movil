// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:f_project_1/presentation/controllers/home_controller.dart';
// import 'package:f_project_1/presentation/pages/profile.dart';
// import 'package:flutter/material.dart';

// void main() {
//   late HomeController homeController;

//   setUp(() {
//     homeController = HomeController();
//     homeController.name.value = 'Ana';
//     Get.put(homeController);
//   });

//   testWidgets('Profile muestra el nombre y botón funciona', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: MyProfile()));

//     expect(find.text('Ana'), findsOneWidget);
//     await tester.tap(find.text('Change name'));
//     await tester.pump();
//     // Verifica navegación
//   });
// }