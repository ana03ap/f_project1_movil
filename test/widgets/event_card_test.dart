import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f_project_1/presentation/widgets/event_card.dart';

void main() {
  testWidgets('EventCard renders correctly and responds to tap',
      (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventCard(
            title: 'Test Event',
            location: 'Test Location',
            date: 'April 27, 2025, 11:00 AM',
            path: 'lib/assets/unbound01.jpeg', 
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    // Verify that the title, location, and date texts are rendered
    expect(find.text('Test Event'), findsOneWidget);
    expect(find.text('Test Location'), findsOneWidget);
    expect(find.text('April 27, 2025, 11:00 AM'), findsOneWidget);

    // Verify that the location icon is rendered
    expect(find.byIcon(Icons.location_on), findsOneWidget);

    // Simulate the tap
    await tester.tap(find.byType(EventCard));
    expect(tapped, isTrue);
  });
}
