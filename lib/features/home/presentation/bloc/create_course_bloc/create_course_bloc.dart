
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/upload_course_usecases.dart';
import 'create_course_event.dart';
import 'create_course_state.dart';
class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState> {
  final UploadCourseUsecases uploadCourseUsecases;

  CreateCourseBloc(this.uploadCourseUsecases) : super(CreateCourseInitial()) {
    on<UploadCourseEvent>(_onUploadCourseEvent);
  }

  
  Future<void> _onUploadCourseEvent(
    UploadCourseEvent event,
    Emitter<CreateCourseState> emit,
  ) async {
    emit(CreateCourseLoading());

    try {
      await uploadCourseUsecases.uploadCourse(
        courseName: event.courseName,
        courseDescription: event.courseDiscription, 
        category: event.category,
        subCategory: event.subCategory,
        sections: event.sections,
        coursePrice: event.coursePrice,
        imagePath: event.imagePath,
      );
    
      emit(UploadCourseSuccess());
    } catch (e) {
      emit(UploadCourseFailure(errorMessage: e.toString()));
    }
  }
}
