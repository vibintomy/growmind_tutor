import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/features/home/data/data_source/saled_course_datasource.dart';
import 'package:growmind_tutuor/features/home/domain/entities/saled_course.dart';
import 'package:growmind_tutuor/features/home/domain/repository/saled_course_repostory.dart';

class SaledCourseRepoImpl implements SaledCourseRepostory {
  final SaledCourseDatasource saledCourseDatasource;

  SaledCourseRepoImpl(this.saledCourseDatasource);

  @override
  Future<List<SaledCourse>> getCourse(String tutorId) async {
    try {
   

      final List<Map<String, dynamic>> saledCourse = await saledCourseDatasource.getTutorById(tutorId);
     
      final courses = saledCourse.map((data) {
      
        return SaledCourse(
          id: data['id']?.toString() ?? '',
          courseName: data['courseName']?.toString() ?? '',
          coursePrice: _parseCoursePrice(data['coursePrice']), 
          imageUrl: data['imageUrl']?.toString() ?? '',
          createdAt: _parseTimestamp(data['createdAt']),
          purchaseCount: _parsePurchaseCount(data['purchasesCount'] ?? data['purchaseCount']), // Handle both variations
        );
      }).toList();

    
      return courses;
    } catch (e, stackTrace) {
     
      throw Exception('Failed to get the data');
    }
  }


  double _parseCoursePrice(dynamic price) {
    if (price is int) return price.toDouble();
    if (price is double) return price;
    if (price is String) return double.tryParse(price) ?? 0.0;
    return 0.0;
  }


  String _parseTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate().toIso8601String();
    }
    return timestamp?.toString() ?? '';
  }


  String _parsePurchaseCount(dynamic purchaseCount) {
    if (purchaseCount is int) return purchaseCount.toString();
    if (purchaseCount is String) return purchaseCount;
    return '0';
  }
}