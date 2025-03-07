abstract class TutorKycEvent {}

class UploadPDFEvent extends TutorKycEvent {
  final String filePath;
  UploadPDFEvent(this.filePath);
}

class SubmitKycEvent extends TutorKycEvent {
  final String name;
  final String email;
  final String profession;
  final String pdfUrl;

  SubmitKycEvent({
    required this.name,
    required this.email,
    required this.pdfUrl,
    required this.profession,
  });
}
