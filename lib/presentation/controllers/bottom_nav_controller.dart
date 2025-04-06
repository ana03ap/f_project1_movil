import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void onTap(int index) {
    currentIndex.value = index;

    final String name = Get.arguments ?? 'Guest';

    if (index == 0) {
      Get.toNamed('/startpage', arguments: name);
    } else if (index == 1) {
      Get.toNamed('/my_events');
    } else if (index == 2) {
      Get.toNamed('/profile', arguments: name);
    }
  }
}
