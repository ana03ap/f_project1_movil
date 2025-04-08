import 'package:get/get.dart';

class BottomNavController extends GetxController {
 
  void onTap(int index) {
    final String name = Get.arguments ?? 'Guest';
    
    if (index == 0) {
      Get.offAllNamed('/startpage', arguments: name);
    } else if (index == 1) {
      Get.offAllNamed('/my_events');
    } else if (index == 2) {
      Get.offAllNamed('/profile', arguments: name);
    }
  }

  int getCurrentIndex() {
    final currentRoute = Get.currentRoute;
    if (currentRoute.contains('/startpage')) return 0;
    if (currentRoute.contains('/my_events')) return 1;
    if (currentRoute.contains('/profile')) return 2;
    return 0; // Default
  }
}