import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/upload_course_usecases.dart';
import 'create_course_event.dart';
import 'create_course_state.dart';

class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState> {
  final UploadCourseUsecases uploadCourseUsecases;

  CreateCourseBloc(this.uploadCourseUsecases) : super(CreateCourseInitial()) {
    on<UploadCourseEvent>(_onUploadCourseEvent);
    on<UpdateCourseEvent>(_onUpdateCourseEvent);
    on<DeleteCourseEvent>(_onDeleteCourse);
    on<DeleteSectionEvent>(_onDeleteSection);
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

  Future<void> _onUpdateCourseEvent(
    UpdateCourseEvent event,
    Emitter<CreateCourseState> emit,
  ) async {
    emit(CreateCourseLoading());

    try {
      await uploadCourseUsecases.updateCourse(
        courseId: event.courseId,
        courseName: event.courseName,
        courseDescription: event.courseDescription,
        category: event.category,
        subCategory: event.subCategory,
        coursePrice: event.coursePrice,
        imagePath: event.imagePath,
        sections: event.sections,
      );
      emit(UpdateCourseSuccess());
    } catch (e) {
      emit(UpdateCourseFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onDeleteCourse(
      DeleteCourseEvent event, Emitter<CreateCourseState> emit) async {
    emit(CreateCourseLoading());
    try {
      await uploadCourseUsecases.deleteCourse(courseId: event.courseId);
      emit(DeletCourseSucess(courseId: event.courseId));
    } catch (e) {
      emit(DeleteCourseFailure(e.toString()));
    }
  }

  Future<void> _onDeleteSection(
      DeleteSectionEvent event, Emitter<CreateCourseState> emit) async {
    emit(CreateCourseLoading());
    try {
      await uploadCourseUsecases.deleteSections(
          courseId: event.courseId, sectionId: event.sectionId);
      emit(DeleteSectionSucess(sectionId: event.sectionId));
    } catch (e) {
      emit(DeleteCourseFailure(e.toString()));
    }
  }
}
