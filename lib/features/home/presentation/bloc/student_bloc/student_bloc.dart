import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/home/domain/entities/student_entities.dart';
import 'package:growmind_tutuor/features/home/domain/usecases/fetch_student_usecases.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/student_bloc/student_event.dart';
import 'package:growmind_tutuor/features/home/presentation/bloc/student_bloc/student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final FetchStudentUsecases fetchStudentUsecases;
  StudentBloc(this.fetchStudentUsecases) : super(StudentStateInitial()) {
    on<GetStudentEvent>((event, emit) async {
      emit(StudentStateLoading());
     
      try {
        final student = await fetchStudentUsecases.call(event.tutorId);
        print('Have the values $student');
      final students = (student as List).cast<StudentEntities>();


        emit(StudentStateLoaded(students));
      } catch (e) {
        emit(StudentStateError());
      }
    });
  }
}
