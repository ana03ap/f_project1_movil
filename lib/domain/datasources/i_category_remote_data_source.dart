
import 'package:f_project_1/data/models/category_model.dart';

abstract class ICategoryRemoteDataSource {
  Future<List<CategoryModel>> fetchCategories();
}
