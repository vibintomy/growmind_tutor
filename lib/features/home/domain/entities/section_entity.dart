class SectionEntity {
  final String id;
  final String videoUrl;
  final String sectionName;
  final String sectionDescription;
  final String createdAt;

  SectionEntity(
      {required this.id,
      required this.videoUrl,
      required this.sectionName,
      required this.sectionDescription,
      required this.createdAt});
  SectionEntity copyWith(
      {String? id,
      String? videoUrl,
      String? sectionName,
      String? sectionDescription,
      String? createdAt}) {
    return SectionEntity(
        id: id ?? this.id,
        videoUrl: videoUrl ?? this.id,
        sectionName: sectionName ?? this.sectionName,
        sectionDescription: sectionDescription ?? this.sectionDescription,
        createdAt: createdAt ?? this.createdAt);
  }
}
