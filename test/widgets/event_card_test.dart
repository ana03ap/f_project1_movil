// Importa los widgets estándar de Flutter
import 'package:flutter/material.dart';
// Importa herramientas para testeo de widgets
import 'package:flutter_test/flutter_test.dart';
// Importa el widget que se va a testear
import 'package:f_project_1/presentation/widgets/event_card.dart';

void main() {
  // Test que verifica que EventCard se renderiza correctamente y responde a taps
  testWidgets('EventCard renders correctly and responds to tap',
      (WidgetTester tester) async {
    // Variable para verificar si se ejecutó el callback onTap
    bool tapped = false;

    // Renderiza la app de prueba con un EventCard dentro de un Scaffold
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventCard(
            title: 'Test Event', // Título del evento
            location: 'Test Location', // Ubicación del evento
            date: 'April 27, 2025, 11:00 AM', // Fecha del evento
            path: 'lib/assets/unbound01.jpeg', // Ruta de imagen
            onTap: () {
              tapped = true; // Cambia el valor cuando se hace tap
            },
          ),
        ),
      ),
    );

    // Verifica que el texto del título esté presente en la pantalla
    expect(find.text('Test Event'), findsOneWidget);
    // Verifica que el texto de la ubicación esté presente
    expect(find.text('Test Location'), findsOneWidget);
    // Verifica que la fecha esté renderizada
    expect(find.text('April 27, 2025, 11:00 AM'), findsOneWidget);

    // Verifica que el ícono de ubicación esté presente
    expect(find.byIcon(Icons.location_on), findsOneWidget);

    // Simula el tap sobre el EventCard
    await tester.tap(find.byType(EventCard));
    // Verifica que la variable haya cambiado, es decir, que el tap fue detectado
    expect(tapped, isTrue);
  });
}
