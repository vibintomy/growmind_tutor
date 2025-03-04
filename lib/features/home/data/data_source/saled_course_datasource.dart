import 'package:cloud_firestore/cloud_firestore.dart';

class SaledCourseDatasource {
  final FirebaseFirestore firebaseFirestore;
  SaledCourseDatasource(this.firebaseFirestore);

  Future<List<Map<String, dynamic>>> getTutorById(String tutorId) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('courses')
          .where('createdBy', isEqualTo: tutorId)
          .get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Failed to load data $e');
    }
  }
}
