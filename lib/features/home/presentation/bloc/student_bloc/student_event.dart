abstract class StudentEvent {}

class GetStudentEvent extends StudentEvent {
  final String tutorId;
  GetStudentEvent(this.tutorId);
}
