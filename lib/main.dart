import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'core/constants/app_colors.dart';
import 'core/constants/app_routes.dart';
import 'presentation/controllers/home_controller.dart';
import 'presentation/controllers/bottom_nav_controller.dart';
import 'presentation/controllers/event_controller.dart';
import 'presentation/controllers/top_nav_controller.dart';

void main() {
  Get.put(HomeController());
  Get.put(BottomNavController());
  Get.put(EventController());
  Get.put(TopNavController()); 
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
          color: AppColors.primary,
          theme: theme.copyWith(
            textTheme: theme.textTheme.apply(
              fontFamily: 'Poppins',
            ),
          ),
          darkTheme: darkTheme.copyWith(
            textTheme: darkTheme.textTheme.apply(
              fontFamily: 'Poppins',
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
