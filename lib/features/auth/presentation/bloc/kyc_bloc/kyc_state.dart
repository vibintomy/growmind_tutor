abstract class TutorKycState {}

class TutuorKYCInitial extends TutorKycState{}

class UploadingPDF extends TutorKycState {}

class PDFUploaded extends TutorKycState {
  final String pdfUrl;
  PDFUploaded(this.pdfUrl);
}

class KYCSubmitting extends TutorKycState {}

class KYCSucess extends TutorKycState {}

class KYCEroor extends TutorKycState {
  final String message;
  KYCEroor(this.message);
}
