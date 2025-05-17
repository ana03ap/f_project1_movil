import 'package:f_project_1/data/models/category_model.dart';
import 'package:f_project_1/domain/datasources/i_category_remote_data_source.dart';
import 'package:f_project_1/domain/repositories/i_category_repository.dart';

class CategoryRepository implements ICategoryRepository {
  final ICategoryRemoteDataSource remoteDataSource;

  CategoryRepository({required this.remoteDataSource});

  @override
  Future<List<CategoryModel>> getCategories() {
    return remoteDataSource.fetchCategories();
  }
}
