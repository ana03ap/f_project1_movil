// import 'package:f_project_1/presentation/widgets/event_card.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:f_project_1/presentation/controllers/top_nav_controller.dart';
// import 'package:f_project_1/presentation/pages/my_events.dart';
// import 'package:flutter/material.dart';

// void main() {
//   late TopNavController topNavController;

//   setUp(() {
//     topNavController = TopNavController();
//     Get.put(topNavController);
//   });

//   testWidgets('MyEvents muestra lista de eventos', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: MyEvents()));

//     expect(find.text('Reproductive Justice'), findsOneWidget);
//     expect(find.byType(EventCard), findsWidgets);
//   });
// }