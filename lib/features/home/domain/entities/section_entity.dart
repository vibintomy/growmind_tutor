class SectionEntity {
  final String id;
  final String videoUrl;
  final String sectionName;
  final String sectionDescription;
  final String createdAt;

  SectionEntity(
      {
        required this.id,
        required this.videoUrl,
      required this.sectionName,
      required this.sectionDescription,
      required this.createdAt});
}
