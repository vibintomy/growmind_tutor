abstract class FetchCategoryEvent {}

class GetCategoryEvent extends FetchCategoryEvent {}

class GetSubCategoryEvent extends FetchCategoryEvent {
  final String categoryId;
  GetSubCategoryEvent({required this.categoryId});
}

class UpdateSelectedSubCategoryEvent extends FetchCategoryEvent {
  final String selectedSubCategory;
  UpdateSelectedSubCategoryEvent(this.selectedSubCategory); 
}
