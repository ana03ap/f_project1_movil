import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Eliminamos el RxInt ya que no lo necesitamos como observable
  // porque ahora determinamos el índice basado en la ruta
  
  void onTap(int index) {
    final String name = Get.arguments ?? 'Guest';
    
    if (index == 0) {
      Get.offNamed('/startpage', arguments: name);
    } else if (index == 1) {
      Get.offNamed('/my_events');
    } else if (index == 2) {
      Get.offNamed('/profile', arguments: name);
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