import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/pages/details_screen.dart';
import 'package:f_project_1/presentation/pages/feedback_screen.dart';
import 'package:f_project_1/presentation/pages/my_events.dart';
import 'package:f_project_1/presentation/pages/profile.dart';
import 'package:f_project_1/presentation/pages/startpage.dart';
import 'package:f_project_1/presentation/pages/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.put(BottomNavController());  // Registra el controlador globalmente
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
      debugShowCheckedModeBanner: false,
      initialRoute: '/startpage',  // empieza por el homescreen tonc
      getPages: [
        GetPage(name: '/', page: () =>  HomeScreen()),
        GetPage(name: '/startpage', page: () =>  Startpage()),
        GetPage(name: '/details_screen', page: () =>  EventDetailsScreen()),
        GetPage(name: '/feedback', page: () =>  FeedbackScreen()),
        GetPage(name: '/profile', page: () => const MyEvents()),
        GetPage(name: '/my_events', page: () => const MyProfile()),
      
      ],
    );
  }
}
