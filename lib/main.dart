import 'package:f_project_1/presentation/controllers/connectivity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loggy/loggy.dart';

import 'core/constants/app_colors.dart';
import 'core/constants/app_routes.dart';
import 'core/network/network_info.dart';
import 'presentation/controllers/home_controller.dart';
import 'presentation/controllers/bottom_nav_controller.dart';
import 'presentation/controllers/event_controller.dart';
import 'presentation/controllers/top_nav_controller.dart';
import 'data/repositories/event_repository_impl.dart';
import 'data/datasources/local/hive_event_source.dart';
import 'data/datasources/remote/remote_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(showColors: true),
  );

  final hiveSource = HiveEventSource();
  await hiveSource.init();

  final networkInfo = NetworkInfo();
  final eventRepo = EventRepositoryImpl(
    hiveSource: hiveSource,
    remoteSource: RemoteDataSource(),
    networkInfo: networkInfo,
  );

  Get.put(HomeController());
  Get.put(BottomNavController());
  Get.put(EventController(repository: eventRepo));
  Get.put(TopNavController());
  Get.put(NetworkInfo());
  Get.put(ConnectivityController());
  runApp(const MyApp(initialRoute: AppRoutes.splash));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

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
            textTheme: theme.textTheme.apply(fontFamily: 'Poppins'),
          ),
          darkTheme: darkTheme.copyWith(
            textTheme: darkTheme.textTheme.apply(fontFamily: 'Poppins'),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
