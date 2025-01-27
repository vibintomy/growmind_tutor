import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/fetch_category_usecases.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_category_bloc/bloc/fetch_category_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_category_bloc/bloc/fetch_category_state.dart';

class FetchCategoryBloc extends Bloc<FetchCategoryEvent, FetchCategoryState> {
  final FetchCategories fetchCategories;
  final FetchSubCategories fetchSubCategories;
  FetchCategoryBloc(this.fetchCategories, this.fetchSubCategories)
      : super(FetchCategoryInitial()) {
    on<GetCategoryEvent>((event, emit) async {
      emit(FetchCategoryLoading());
      try {
        final categories = await fetchCategories.call();
        emit(FetchCategoryLoaded(categories: categories));
      } catch (e) {
        emit(FetchCategoryError(error: e.toString()));
      }
    });

    on<GetSubCategoryEvent>((event, emit) async {
      emit(FetchCategoryLoading());
      try {
        final subcategory = await fetchSubCategories.callSub(event.categoryId);
        emit(FetchSubCategoryLoaded(subcategories: subcategory));
      } catch (e) {
        emit(FetchCategoryError(error: e.toString()));
      }
    });
    on<UpdateSelectedSubCategoryEvent>((event, emit) {
      emit(FetchSubCategoryLoaded(
          subcategories: (state as FetchSubCategoryLoaded).subcategories,
          selectedSubcategories: event.selectedSubCategory));
    });
  }
}
