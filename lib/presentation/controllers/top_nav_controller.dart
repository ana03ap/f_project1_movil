import 'package:get/get.dart';

class TopNavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void onTap(int index) {
    currentIndex.value = index;
  }
}
