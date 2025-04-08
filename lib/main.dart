import 'package:f_project_1/core/constants/app_routes.dart';
import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  Get.put(HomeController());
  Get.put(BottomNavController());
  Get.put(EventController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) {
        return GetMaterialApp(
          title: 'PuntoG',
          theme: theme.copyWith(
            textTheme: GoogleFonts.leagueSpartanTextTheme(theme.textTheme),
          ),
          darkTheme: darkTheme.copyWith(
            textTheme: GoogleFonts.leagueSpartanTextTheme(darkTheme.textTheme),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
