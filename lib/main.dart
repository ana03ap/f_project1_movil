import 'package:f_project_1/presentation/pages/feedback_screen.dart';
import 'package:f_project_1/presentation/pages/startpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation/pages/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TuBoleta',
      theme: ThemeData(
        textTheme: GoogleFonts.leagueSpartanTextTheme(),
      ),
      home:   HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
