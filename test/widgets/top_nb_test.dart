// Importa el widget que se va a testear: la barra superior de navegación
import 'package:f_project_1/presentation/widgets/top_nav_bar.dart';
// Importa widgets de Flutter
import 'package:flutter/material.dart';
// Importa herramientas para testeo de widgets
import 'package:flutter_test/flutter_test.dart';
// Importa GetX para manejo de estado y dependencias
import 'package:get/get.dart';
// Importa el controlador asociado al TopNavBar
import 'package:f_project_1/presentation/controllers/top_nav_controller.dart';

void main() {
  // Asegura que el binding de widgets esté inicializado para el test
  TestWidgetsFlutterBinding.ensureInitialized();

  // Agrupa los tests relacionados con TopNavBar
  group('TopNavBar Widget Tests', () {
    // Declaración del controlador que se inyectará
    late TopNavController controller;

    // Se ejecuta antes de cada test
    setUp(() {
      Get.testMode = true; // Activa el modo test de GetX
      controller = TopNavController(); // Crea instancia del controlador
      Get.put<TopNavController>(controller); // Inyecta el controlador con GetX
    });

    // Se ejecuta después de cada test
    tearDown(() => Get.reset()); // Limpia todos los bindings de GetX

    // Test que verifica la renderización de las pestañas y el cambio de color
    testWidgets('renders both tabs and updates color on tap',
        (WidgetTester tester) async {
      // Construye el widget dentro de un Scaffold
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: TopNavBar(), // Inserta el widget a probar
          ),
        ),
      );

      // Verifica que se renderizan ambos textos
      expect(find.text('Upcoming Events'), findsOneWidget);
      expect(find.text('Past Events'), findsOneWidget);

      // Obtiene los widgets de texto para verificar sus estilos
      Text upcomingText = tester.widget<Text>(find.text('Upcoming Events'));
      Text pastText = tester.widget<Text>(find.text('Past Events'));

      // Verifica que por defecto "Upcoming" esté púrpura y "Past" gris
      expect(upcomingText.style?.color, Colors.purple);
      expect(pastText.style?.color, Colors.grey);

      // Simula un tap en "Past Events"
      await tester.tap(find.text('Past Events'));
      await tester.pump(); // Refresca el widget después del tap

      // Vuelve a obtener los textos actualizados
      upcomingText = tester.widget<Text>(find.text('Upcoming Events'));
      pastText = tester.widget<Text>(find.text('Past Events'));

      // Verifica que ahora "Past" esté púrpura y "Upcoming" gris
      expect(upcomingText.style?.color, Colors.grey);
      expect(pastText.style?.color, Colors.purple);

      // Verifica que el controlador actualizó correctamente el índice seleccionado
      expect(controller.currentIndex.value, 1);
    });
  });
}
