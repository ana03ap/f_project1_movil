// Importa widgets y componentes visuales de Flutter
import 'package:flutter/material.dart';
// Importa utilidades para testeo de widgets
import 'package:flutter_test/flutter_test.dart';
// Importa GetX para gestión de estado y dependencias
import 'package:get/get.dart';

// Importa el controlador real del BottomNavBar (a reemplazar en el test)
import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
// Importa el widget BottomNavBar que se va a probar
import 'package:f_project_1/presentation/widgets/bottom_nav_bar.dart';

// Clase falsa que reemplaza el controlador BottomNavController para los tests
class FakeBottomNavController extends GetxController
    implements BottomNavController {
  // Guarda el índice que fue presionado
  int tappedIndex = -1;

  // Método que simula el comportamiento de onTap
  @override
  void onTap(int index) {
    tappedIndex = index;
  }

  // Devuelve el índice actual (fijo en 0 para este test)
  @override
  int getCurrentIndex() => 0;
}

void main() {
  // Instancia del controlador falso
  late FakeBottomNavController fakeController;

  // Se ejecuta antes de cada test
  setUp(() {
    Get.testMode = true; // Activa el modo de test en GetX
    fakeController = FakeBottomNavController(); // Crea el controlador falso
    Get.put<BottomNavController>(fakeController); // Lo inyecta en el sistema GetX
  });

  // Se ejecuta después de cada test
  tearDown(() {
    Get.reset(); // Limpia todos los bindings de GetX
  });

  // Prueba que el BottomNavBar muestra los íconos y responde a taps
  testWidgets('BottomNavBar shows items and calls onTap when tapped',
      (WidgetTester tester) async {
    // Renderiza el widget en un entorno de prueba
    await tester.pumpWidget(
      GetMaterialApp( // Usa GetMaterialApp para que GetX funcione
        home: Scaffold(
          bottomNavigationBar: BottomNavBar(), // Coloca el BottomNavBar en pantalla
        ),
      ),
    );

    // Verifica que los textos de los items existan
    expect(find.text('Events'), findsOneWidget);
    expect(find.text('My Events'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Simula un tap en el ícono de eventos
    await tester.tap(find.byIcon(Icons.event));
    await tester.pumpAndSettle();
    // Verifica que el índice registrado sea 0
    expect(fakeController.tappedIndex, 0);

    // Simula un tap en el ícono de perfil
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    // Verifica que el índice registrado sea 2
    expect(fakeController.tappedIndex, 2);

    // Simula un tap en el ícono de "My Events"
    await tester.tap(find.byIcon(Icons.list));
    await tester.pumpAndSettle();
    // Verifica que el índice registrado sea 1
    expect(fakeController.tappedIndex, 1);
  });
}
