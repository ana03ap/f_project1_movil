import 'dart:math';

import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:f_project_1/domain/usecases/get_categories_usecase.dart';
import 'package:f_project_1/data/models/category_model.dart';

class HomeController extends GetxController {
  final RxString name = ''.obs;
  final RxList<CategoryModel> categories =
      <CategoryModel>[].obs; // Lista reactiva para las categorías
  final RxBool isLoading = false.obs; // Estado para manejar la carga
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeController({required this.getCategoriesUseCase});

  @override
  void onInit() {
    super.onInit();
    _loadNameFromPrefs();
    fetchCategories(); //Llamamos a fetchCategories cuando se inicializa el controlador
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

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final fetchedCategories = await getCategoriesUseCase.call();
      logInfo(
          "Fetched categories: $fetchedCategories"); // Muestra las categorías en la consola
      categories.value =
          fetchedCategories; // Asignamos las categorías obtenidas
    } catch (e) {
      logError('Failed to fetch categories: $e');
    } finally {
      isLoading(false);
    }
  }
}
