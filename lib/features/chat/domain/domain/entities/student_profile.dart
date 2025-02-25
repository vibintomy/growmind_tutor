class StudentProfile {
  final String id;
  final String name;
  final String? imageUrl;

  StudentProfile({
    required this.id,
    required this.name,
    this.imageUrl,
  });
}
