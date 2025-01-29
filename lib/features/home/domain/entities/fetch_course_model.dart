import 'package:growmind_tutuor/features/home/domain/entities/section_entity.dart';

class CourseEntity {
  final String id;
  final String category;
  final String courseName;
  final String courseDescription;
  final String coursePrice;
  final String imageUrl;
  final String subCategory;
  final String createdBy;
  final String createdAt;
  final List<SectionEntity> sections;
  CourseEntity(
      {required this.id,
      required this.category,
      required this.courseName,
      required this.courseDescription,
      required this.coursePrice,
      required this.imageUrl,
      required this.subCategory,
      required this.createdBy,
      required this.createdAt,
      required this.sections});
}
