// import 'package:f_project_1/data/usescases_impl/check_event_version_usecase_impl.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:loggy/loggy.dart';

// import 'core/constants/app_colors.dart';
// import 'core/constants/app_routes.dart';
// import 'core/network/network_info.dart';

// import 'data/datasources/local/event_local_data_source.dart';
// import 'data/datasources/remote/event_remote_data_source.dart';
// import 'data/repositories/event_repository_impl.dart';


// import 'domain/usecases/filter_events.dart';
// import 'domain/usecases/join_event.dart';
// import 'domain/usecases/unjoin_event.dart';

// import 'presentation/controllers/connectivity_controller.dart';
// import 'presentation/controllers/event_controller.dart';
// import 'presentation/controllers/home_controller.dart';
// import 'presentation/controllers/top_nav_controller.dart';
// import 'presentation/controllers/bottom_nav_controller.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   Loggy.initLoggy(logPrinter: const PrettyPrinter(showColors: true));

//   // Inicializar Hive
//   final localDataSource = EventLocalDataSource();
//   await localDataSource.init();

//   // Fuente remota y conectividad
//   final remoteDataSource = EventRemoteDataSource();
//   final networkInfo = NetworkInfo();

//   // Repositorio
//   final eventRepo = EventRepositoryImpl(
//     localDataSource: localDataSource,
//     remoteDataSource: remoteDataSource,
//     networkInfo: networkInfo,
//   );

//   // Casos de uso
//   final joinEvent = JoinEvent();
//   final unjoinEvent = UnjoinEvent();
//   final filterEvents = FilterEvents();
//   final checkVersion = CheckEventVersionUseCaseImpl(
//     local: localDataSource,
//     remote: remoteDataSource,
//   );

//   // Inyección de dependencias
//   Get.put(HomeController());
//   Get.put(BottomNavController());
//   Get.put(TopNavController());
//   Get.put(NetworkInfo());
//   Get.put(ConnectivityController());
//   Get.put(EventController(
//     repository: eventRepo,
//     joinEventUseCase: joinEvent,
//     unjoinEventUseCase: unjoinEvent,
//     filterEventsUseCase: filterEvents,
//     checkVersionUseCase: checkVersion,
//   ));

//   runApp(const MyApp(initialRoute: AppRoutes.splash));
// }

// class MyApp extends StatelessWidget {
//   final String initialRoute;

//   const MyApp({Key? key, required this.initialRoute}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AdaptiveTheme(
//       light: ThemeData.light(useMaterial3: true),
//       dark: ThemeData.dark(useMaterial3: true),
//       initial: AdaptiveThemeMode.light,
//       builder: (theme, darkTheme) {
//         return GetMaterialApp(
//           title: 'PuntoG',
//           color: AppColors.primary,
//           theme: theme.copyWith(
//             textTheme: theme.textTheme.apply(fontFamily: 'Poppins'),
//           ),
//           darkTheme: darkTheme.copyWith(
//             textTheme: darkTheme.textTheme.apply(fontFamily: 'Poppins'),
//           ),
//           debugShowCheckedModeBanner: false,
//           initialRoute: initialRoute,
//           getPages: AppRoutes.routes,
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:loggy/loggy.dart';

import 'package:f_project_1/core/constants/app_colors.dart';
import 'package:f_project_1/core/constants/app_routes.dart';
import 'package:f_project_1/core/network/network_info.dart';

import 'package:f_project_1/data/datasources/local/event_local_data_source.dart';
import 'package:f_project_1/data/datasources/remote/event_remote_data_source.dart';
import 'package:f_project_1/data/datasources/remote/version_remote_data_source.dart';
import 'package:f_project_1/data/repositories/event_repository_impl.dart';
import 'package:f_project_1/data/usescases_impl/check_event_version_usecase_impl.dart'; // ruta corregida

import 'package:f_project_1/domain/usecases/filter_events.dart';
import 'package:f_project_1/domain/usecases/join_event.dart';
import 'package:f_project_1/domain/usecases/unjoin_event.dart';

import 'package:f_project_1/presentation/controllers/connectivity_controller.dart';
import 'package:f_project_1/presentation/controllers/event_controller.dart';
import 'package:f_project_1/presentation/controllers/home_controller.dart';
import 'package:f_project_1/presentation/controllers/top_nav_controller.dart';
import 'package:f_project_1/presentation/controllers/bottom_nav_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar el logger
  Loggy.initLoggy(logPrinter: const PrettyPrinter(showColors: true));

 
  // Inicializar Hive
  final localDataSource = EventLocalDataSource();
  await localDataSource.init();

  // Fuentes remotas y network
  final remoteDataSource = EventRemoteDataSource();
  final versionRemoteDataSource = VersionRemoteDataSource();
  final networkInfo = NetworkInfo();

  // Repositorio
  final eventRepo = EventRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
    networkInfo: networkInfo,
  );

  // Casos de uso
 final joinEvent = JoinEvent(eventRepo);
  final unjoinEvent = UnjoinEvent(eventRepo);
  final filterEvents = FilterEvents();
  final checkVersion = CheckEventVersionUseCaseImpl(
    local: localDataSource,
    remote: versionRemoteDataSource,
  );

  // Inyección de dependencias
  Get.put(HomeController());
  Get.put(BottomNavController());
  Get.put(TopNavController());
  Get.put(NetworkInfo());            
  Get.put(ConnectivityController()); 
  Get.put(EventController(
    repository:           eventRepo,
    joinEventUseCase:     joinEvent,
    unjoinEventUseCase:   unjoinEvent,
    filterEventsUseCase:  filterEvents,
    checkVersionUseCase:  checkVersion,
  ));

  runApp(const MyApp(initialRoute: AppRoutes.splash));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark:  ThemeData.dark(useMaterial3: true),
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
