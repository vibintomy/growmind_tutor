import 'package:growmind_tutuor/features/home/domain/entities/fetch_model.dart';

abstract class FetchCategoryState {}

class FetchCategoryInitial extends FetchCategoryState {}

class FetchCategoryLoading extends FetchCategoryState {}

class FetchCategoryLoaded extends FetchCategoryState {
  final List<Category> categories;
  FetchCategoryLoaded({required this.categories});
}

class FetchSubCategoryLoaded extends FetchCategoryState {
  final List<Subcategory> subcategories;
  final String? selectedSubcategories;
  FetchSubCategoryLoaded({required this.subcategories,this.selectedSubcategories});
}

class FetchCategoryError extends FetchCategoryState {
  final String error;
  FetchCategoryError({required this.error});
}
