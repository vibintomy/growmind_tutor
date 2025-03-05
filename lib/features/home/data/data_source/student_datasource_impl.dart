import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/features/home/data/data_source/student_datasource.dart';
import 'package:growmind_tutuor/features/home/domain/entities/student_entities.dart';

class StudentDatasourceImpl implements StudentDatasource {
  final FirebaseFirestore firebaseFirestore;

  StudentDatasourceImpl(this.firebaseFirestore);

  @override
  Future<List<StudentEntities>> getStudent(String tutorId) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('users')
          .where('mentor', arrayContains: tutorId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return []; 
      }

   
      final students = querySnapshot.docs.map((doc) {
        final userData = doc.data();
        return StudentEntities(
          displayName: userData['displayName'] ?? '',
          imageUrl: userData['imageUrl'] ?? '',
        );
      }).toList();

   
      return students;
    } catch (e) {

      throw Exception('Error fetching students: $e');
    }
  }
}
