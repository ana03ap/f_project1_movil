import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/pages/details_screen.dart';
import 'package:flutter/material.dart';

void main() {
  setUpAll(() {
    // Configuración para testing en GetX 2025
    Get.testMode = true; // La forma correcta en GetX actual
    
    // Mock de rutas - forma actualizada
    Get.reset();
    Get.addPages([
      GetPage(
        name: '/startpage', 
        page: () => const Scaffold(body: Center(child: Text('Página Mock'))),
        binding: BindingsBuilder(() {
          Get.lazyPut<BottomNavController>(() => BottomNavController());
        }),
      ),
    ]);
  });

  setUp(() {
    // Registro de controladores
    Get.put(EventController());
    Get.put(BottomNavController());

    // Configura datos de prueba
    final eventController = Get.find<EventController>();
    eventController.selectedEvent.value = {
      "title": "Evento Flutter 2025",
      "location": "Online",
      "details": "Novedades de Flutter 2025",
      "participants": 200,
      "availableSpots": 50,
      "date": "20 NOV 2025",
    };
  });

  tearDown(() {
    Get.reset(); // Limpieza completa
  });

  testWidgets('Muestra detalles del evento correctamente', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: EventDetailsScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Evento Flutter 2025'), findsOneWidget);
    expect(find.text('Online'), findsOneWidget);
    expect(find.text('Available spots: 50'), findsOneWidget);
  });

  testWidgets('Interacción con botón de participación', (tester) async {
    final eventController = Get.find<EventController>();
    eventController.availableSpots.value = 10;
    eventController.isJoined.value = false;

    await tester.pumpWidget(
      GetMaterialApp(
        home: EventDetailsScreen(),
      ),
    );
    await tester.pumpAndSettle();

    final joinButton = find.byWidgetPredicate(
      (widget) => widget is ElevatedButton && 
                 widget.child is Text && 
                 (widget.child as Text).data!.contains('Join'),
    );
    
    await tester.tap(joinButton);
    await tester.pump();

    expect(eventController.isJoined.value, true);
  });
}