abstract class CourseEvent {}

class FetchCourseEvent extends CourseEvent {
  final String tutorId;
  FetchCourseEvent({required this.tutorId});
}
