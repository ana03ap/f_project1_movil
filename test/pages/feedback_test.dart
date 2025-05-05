// import 'package:f_project_1/data/datasources/hive/hive_event_source.dart';
// import 'package:f_project_1/data/datasources/remote_data_source.dart';
// import 'package:f_project_1/data/models/event_model.dart';
// import 'package:f_project_1/data/repositories/event_repository_impl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:f_project_1/presentation/controllers/event_controller.dart';
// import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
// import 'package:f_project_1/presentation/pages/feedback_screen.dart';

// void main() {
//   late EventController controller;

//   setUp(() async {
//     Get.reset();

//     // Crear instancia del repositorio real
//     final eventRepository = EventRepositoryImpl(
//       hiveSource: HiveEventSource(),
//       remoteSource: RemoteDataSource(), networkInfo: null,
//     );

//     // Obtener evento simulado (usando await correctamente)
//     final events = await eventRepository.getAllEvents();
//     final mockEvent = events.first as EventModel;

//     // Registrar el controlador con ese repositorio
//     controller = Get.put(
//       EventController(repository: eventRepository),
//     );

//     // También registras el BottomNavController
//     Get.put(BottomNavController());

//     // Seleccionar el evento antes de iniciar la pantalla
//     controller.selectEvent(mockEvent);
//   });

//   tearDown(() {
//     Get.reset();
//   });

//   testWidgets('Can press star and submit without crashing', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       GetMaterialApp(
//         home: FeedbackScreen(),
//       ),
//     );

//     // Tap estrella 3 (rating 3)
//     final thirdStar = find.byIcon(Icons.star).at(2);
//     await tester.tap(thirdStar);
//     await tester.pump();

//     // (Opcional) puedes verificar que la estrella se haya activado
//     expect(
//       (tester.widget(thirdStar) as Icon).color,
//       equals(Colors.amber), // o el color que uses al seleccionar
//     );
//   });
// }
