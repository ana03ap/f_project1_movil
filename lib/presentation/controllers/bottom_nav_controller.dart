import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void onTap(int index) {
    currentIndex.value = index;
    if (index == 0) {
      Get.toNamed('/startpage');
    } else if (index == 1) {
      Get.toNamed('/my_events');
    } else if (index == 2) {
      Get.toNamed('/profile');
      
    }
  }
}
