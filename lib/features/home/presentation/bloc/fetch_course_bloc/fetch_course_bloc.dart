import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/fetch_course_usecases.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/fetch_course_bloc/fetch_course_state.dart';

class FetchCourseBloc extends Bloc<CourseEvent, CourseState> {
  final FetchCourseUsecases fetchCourseUsecases;
  FetchCourseBloc(this.fetchCourseUsecases) : super(CourseInitial()) {
    on<FetchCourseEvent>((event, emit) async { 
     emit(CourseLoading());
      try {
        final course = await fetchCourseUsecases.call(event.tutorId);
        emit(CourseLoaded(course));
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });
  }
}
