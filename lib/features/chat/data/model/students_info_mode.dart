import 'package:growmind_tutuor/features/chat/domain/domain/entities/student_profile.dart';

class StudentProfileModel extends StudentProfile {
  StudentProfileModel({
    required super.id,
    required super.name,
    super.imageUrl,
  
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json, String id) {
    return StudentProfileModel(
      id: id,
      name: json['displayName'] ?? 'Unknown Student',
      imageUrl: json['imageUrl'],
     
    );
  }
}
