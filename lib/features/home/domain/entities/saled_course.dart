

class SaledCourse {
  final String id;
  final String courseName;
  final double coursePrice;
  final String imageUrl;
  final String createdAt;
  final String purchaseCount;
  SaledCourse(
      {required this.id,
      required this.courseName,
      required this.coursePrice,
      required this.imageUrl,
      required this.purchaseCount,
      required this.createdAt});
}
