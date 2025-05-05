
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final RxString name = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadNameFromPrefs();
  }

  void setName(String newName) async {
    name.value = newName;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', newName);
  }

  void _loadNameFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('user_name');
    if (savedName != null) name.value = savedName;
  }

  Future<void> clearName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    name.value = '';
  }
}
