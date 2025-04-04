import 'package:get/get.dart';
import 'package:f_project_1/presentation/pages/home_screen.dart';
import 'package:f_project_1/presentation/pages/startpage.dart';
import 'package:f_project_1/presentation/pages/details_screen.dart';
import 'package:f_project_1/presentation/pages/feedback_screen.dart';
import 'package:f_project_1/presentation/pages/my_events.dart';
import 'package:f_project_1/presentation/pages/profile.dart';

class AppRoutes {
  static const String home = '/';
  static const String startPage = '/startpage';
  static const String detailsScreen = '/details_screen';
  static const String feedback = '/feedback';
  static const String profile = '/profile';
  static const String myEvents = '/my_events';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: startPage, page: () => Startpage()),
    GetPage(name: detailsScreen, page: () => EventDetailsScreen()),
    GetPage(name: feedback, page: () => FeedbackScreen()),
    GetPage(name: profile, page: () => const MyProfile()),
    GetPage(name: myEvents, page: () => MyEvents()),
  ];
}
