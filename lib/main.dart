import 'package:f_project_1/core/constants/app_routes.dart';
import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.put(BottomNavController()); 
  Get.put(EventController()); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PuntoG',
      theme: ThemeData(
        textTheme: GoogleFonts.leagueSpartanTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
       initialRoute: AppRoutes.splash,  
      getPages: AppRoutes.routes, 
      
    );
  }
}
