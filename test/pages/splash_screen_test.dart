import 'package:flutter_test/flutter_test.dart';

import 'package:f_project_1/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
void main() {
  testWidgets('SplashScreen navega después de 2 segundos', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    // Avanza el tiempo
    await tester.pump(const Duration(seconds: 2));
    // Verifica que navegó (mockeando Get.offNamed)
  });
}