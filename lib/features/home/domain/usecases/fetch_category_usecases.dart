import 'package:growmind_tutuor/features/home/domain/entities/fetch_model.dart';
import 'package:growmind_tutuor/features/home/domain/repository/fetch_category_repo.dart';

class FetchCategories {
  final FetchCategoryRepo fetchCategoryRepo;
  FetchCategories(this.fetchCategoryRepo);
  Future<List<Category>> call() async {
    return fetchCategoryRepo.fetchCategories();
  }
}

class FetchSubCategories {
  final FetchCategoryRepo fetchCategoryRepo;
  FetchSubCategories(this.fetchCategoryRepo);
  Future<List<Subcategory>> callSub(String categoryId) async {
    return fetchCategoryRepo.fetchSubCategories(categoryId);
  }
}
