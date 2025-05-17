import 'package:f_project_1/data/models/category_model.dart';

abstract class ICategoryRepository {
  Future<List<CategoryModel>> getCategories();
}
