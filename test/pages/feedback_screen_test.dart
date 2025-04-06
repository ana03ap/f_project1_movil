// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:f_project_1/presentation/pages/feedback_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   testWidgets('FeedbackScreen envía feedback con rating', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: FeedbackScreen()));

//     // Ingresa feedback
//     await tester.enterText(find.byType(TextField), 'Great event!');
//     expect(find.text('Great event!'), findsOneWidget);

//     // Selecciona 4 estrellas
//     await tester.tap(find.byIcon(Icons.star).at(3));
//     await tester.pump();

//     // Presiona "Submit"
//     await tester.tap(find.text('Submit'));
//     await tester.pump();

//     // Verifica Snackbar
//     expect(Get.isSnackbarOpen, true);
//   });
// }