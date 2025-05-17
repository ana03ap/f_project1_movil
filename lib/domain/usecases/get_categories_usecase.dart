import 'package:f_project_1/data/models/category_model.dart';
import 'package:f_project_1/domain/repositories/i_category_repository.dart';

class GetCategoriesUseCase {
  final ICategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<List<CategoryModel>> call() {
    return repository.getCategories();
  }
}
