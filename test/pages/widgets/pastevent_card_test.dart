/*import 'package:f_project_1/presentation/widgets/pastevent_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:f_project_1/data/events_data.dart';

void main() {
  testWidgets('PastEventCard shows correct data and responds to tap',
      (WidgetTester tester) async {
    // Crear instancia de Event con todos los parámetros necesarios
    final event = Event(
      id: 1,
      title: 'Evento Test 1',
      location: 'Lugar 1',
      details: 'Detalles del evento',
      availableSpots: 10,
      participants: 20,
      date: '2023-06-01',
      path:
          'lib/assets/unbound01.jpeg', // Asegúrate de que exista o usa un mock
      type: 'Test',
      isJoined: true,
    );

    // Simula que el evento ya tiene ratings
    event.ratings.addAll([4.0, 5.0, 3.0]);
    event.updateAverageRating();

    bool tapped = false;

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: PastEventCard(
            event: event,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verifica que se muestra el título
    expect(find.text('Evento Test 1'), findsOneWidget);

    // Verifica que se muestra la fecha
    expect(find.text('2023-06-01'), findsOneWidget);

    // Verifica que se muestra el texto "Give a feedback!"
    expect(find.text('Give a feedback!'), findsOneWidget);

    // Verifica que se muestra el promedio del rating
    expect(find.text(event.averageRating.value.toStringAsFixed(1)),
        findsOneWidget);

    // Simula un tap
    await tester.tap(find.byType(PastEventCard));
    await tester.pump(); // para que se registre el tap

    expect(tapped, isTrue);
  });
}
*/