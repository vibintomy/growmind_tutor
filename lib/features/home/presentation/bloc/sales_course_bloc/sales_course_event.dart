abstract class SalesCourseEvent {}

class GetSalesCourseEvent extends SalesCourseEvent {
  final String tutorId;
  GetSalesCourseEvent({required this.tutorId});
}
