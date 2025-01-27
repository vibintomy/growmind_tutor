import 'package:growmind_tutuor/features/home/domain/entities/fetch_model.dart';

abstract class FetchCategoryRepo {
  Future<List<Category>> fetchCategories();
  Future<List<Subcategory>> fetchSubCategories(String categoryId);
}
