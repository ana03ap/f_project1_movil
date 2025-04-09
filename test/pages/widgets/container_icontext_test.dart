import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f_project_1/presentation/widgets/container_icon_with_text.dart';

void main() {
  testWidgets('ContainerIconWithText renders correctly when selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ContainerIconWithText(
            icon: Icons.home,
            label: 'Home',
            isSelected: true,
          ),
        ),
      ),
    );

    // Verifica que el texto esté presente
    expect(find.text('Home'), findsOneWidget);

    // Verifica que el ícono esté presente
    expect(find.byIcon(Icons.home), findsOneWidget);

    // Verifica que el texto tenga color púrpura
    final Text text = tester.widget(find.text('Home'));
    expect(text.style?.color, Colors.purple);

    // Verifica que el ícono tenga color púrpura
    final Icon icon = tester.widget(find.byIcon(Icons.home));
    expect(icon.color, Colors.purple);
  });

  testWidgets('ContainerIconWithText renders correctly when not selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ContainerIconWithText(
            icon: Icons.settings,
            label: 'Settings',
            isSelected: false,
          ),
        ),
      ),
    );

    // Verifica que el texto esté presente
    expect(find.text('Settings'), findsOneWidget);

    // Verifica que el ícono esté presente
    expect(find.byIcon(Icons.settings), findsOneWidget);

    // Verifica que el texto tenga color gris
    final Text text = tester.widget(find.text('Settings'));
    expect(text.style?.color, Colors.grey);

    // Verifica que el ícono tenga color gris
    final Icon icon = tester.widget(find.byIcon(Icons.settings));
    expect(icon.color, Colors.grey);
  });
}
