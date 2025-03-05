import 'package:growmind_tutuor/features/home/domain/entities/student_entities.dart';

abstract class StudentState {}

class StudentStateInitial extends StudentState {}

class StudentStateLoading extends StudentState {}

class StudentStateLoaded extends StudentState {
  final List<StudentEntities> student;
  final DateTime timeStamp;
  StudentStateLoaded(this.student) : timeStamp = DateTime.now();
}

class StudentStateError extends StudentState {}
