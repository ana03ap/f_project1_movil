// Importa los widgets de Flutter
import 'package:flutter/material.dart';
// Importa herramientas de testeo de widgets
import 'package:flutter_test/flutter_test.dart';
// Importa el widget que se quiere testear
import 'package:f_project_1/presentation/widgets/container_icon_with_text.dart';

void main() {
  // Primer test: cuando el widget está seleccionado (isSelected: true)
  testWidgets('ContainerIconWithText renders correctly when selected',
      (WidgetTester tester) async {
    // Construye la app con el widget dentro de un Scaffold
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ContainerIconWithText(
            label: 'Home',    // Texto debajo del ícono
            isSelected: true, // Se indica que está seleccionado (color púrpura esperado)
          ),
        ),
      ),
    );

    // Verifica que el texto 'Home' se muestre en pantalla
    expect(find.text('Home'), findsOneWidget);

    // Verifica que el texto sea de color púrpura cuando está seleccionado
    final Text text = tester.widget(find.text('Home'));
    expect(text.style?.color, Colors.purple);

    // Verifica que el ícono también sea de color púrpura
    final Icon icon = tester.widget(find.byIcon(Icons.home));
    expect(icon.color, Colors.purple);
  });

  // Segundo test: cuando el widget NO está seleccionado (isSelected: false)
  testWidgets('ContainerIconWithText renders correctly when not selected',
      (WidgetTester tester) async {
    // Construye la app con el widget no seleccionado
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ContainerIconWithText(
            label: 'Settings',    // Texto debajo del ícono
            isSelected: false,    // No está seleccionado (color gris esperado)
          ),
        ),
      ),
    );

    // Verifica que el texto 'Settings' esté presente
    expect(find.text('Settings'), findsOneWidget);

    // Verifica que el texto sea de color gris
    final Text text = tester.widget(find.text('Settings'));
    expect(text.style?.color, Colors.grey);

    // Verifica que el ícono también sea de color gris
    final Icon icon = tester.widget(find.byIcon(Icons.settings));
    expect(icon.color, Colors.grey);
  });
}
