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

    // Check that the text is present
    expect(find.text('Home'), findsOneWidget);

    // Check that the icon is present
    expect(find.byIcon(Icons.home), findsOneWidget);

    // Check that the text has purple color
    final Text text = tester.widget(find.text('Home'));
    expect(text.style?.color, Colors.purple);

    // Check that the icon has purple color
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

    // Check that the text is present
    expect(find.text('Settings'), findsOneWidget);

    // Check that the icon is present
    expect(find.byIcon(Icons.settings), findsOneWidget);

    // Check that the text has gray color
    final Text text = tester.widget(find.text('Settings'));
    expect(text.style?.color, Colors.grey);

    // Check that the icon has gray color
    final Icon icon = tester.widget(find.byIcon(Icons.settings));
    expect(icon.color, Colors.grey);
  });
}
