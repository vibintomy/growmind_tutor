import 'package:bloc/bloc.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/upload_course_usecases.dart';
import 'create_course_event.dart';
import 'create_course_state.dart';

class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState> {
  final UploadCourseUsecases uploadCourseUsecases;

  CreateCourseBloc(this.uploadCourseUsecases) : super(CreateCourseInitial()) {
    on<UploadVedioImageEvent>(_onUploadVedioImageEvent);
    on<UploadCourseEvent>(_onUploadCourseEvent);
  }

  /// Handles the `UploadVedioImageEvent`.
  Future<void> _onUploadVedioImageEvent(
    UploadVedioImageEvent event,
    Emitter<CreateCourseState> emit,
  ) async {
    emit(CreateCourseLoading());
    try {
      final mediaUrls = await uploadCourseUsecases.uploadVedioImage(
        vedioPath: event.VedioFilePath,
        imagePath: event.ImagePath,
      );
      emit(UploadVideoImageSuccess(mediaUrls: mediaUrls));
    } catch (e) {
      emit(UploadVideoImageFailure(errorMessage: e.toString()));
    }
  }

  /// Handles the `UploadCourseEvent`.
  Future<void> _onUploadCourseEvent(
    UploadCourseEvent event,
    Emitter<CreateCourseState> emit,
  ) async {
    emit(CreateCourseLoading());
    try {
      print('Uploading course');
      await uploadCourseUsecases.uploadCourse(
        courseName: event.courseName,
        courseDiscription: event.courseDiscription,
        category: event.category,
        subCategory: event.subCategory,
        sections: event.sections,
        coursePrice: event.coursePrice,
        imagePath: event.imagePath,
      );
      print('data suceesfully fetching');
      emit(UploadCourseSuccess());
    } catch (e) {
      emit(UploadCourseFailure(errorMessage: e.toString()));
    }
  }
}
