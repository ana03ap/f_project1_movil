import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  runApp(const Home());
}
