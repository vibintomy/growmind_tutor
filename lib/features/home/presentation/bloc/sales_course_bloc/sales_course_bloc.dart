import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/get_saled_course_usecase.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/sales_course_bloc/sales_course_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/sales_course_bloc/sales_course_state.dart';

class SalesCourseBloc extends Bloc<SalesCourseEvent, SalesCourseState> {
  final GetSaledCourseUsecase getSaledCourseUsecase;
  SalesCourseBloc(this.getSaledCourseUsecase) : super(SalesCourseInitial()) {
    on<GetSalesCourseEvent>((event, emit) async {
      emit(SalesCourseLoading());
   
      try {
        final courses = await getSaledCourseUsecase.call(event.tutorId);
        print(courses);
        emit(SalesCourseLoaded(courses: courses));
      } catch (e) {
        emit(SalesCourseError('Failed to load the datas $e'));
      }
    });
  }
}
