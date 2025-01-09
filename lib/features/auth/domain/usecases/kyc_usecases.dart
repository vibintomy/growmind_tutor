
import 'package:growmind_tutuor/features/auth/domain/repositories/tutor_repositories.dart';

class UploadPDFUseCase {
  final TutorRepositories repositories;
  UploadPDFUseCase(this.repositories);

  Future<String> call(String filePath) async {
    return repositories.uploadPdf(filePath);
  }
}

class SubmitKycUseCase {
  final TutorRepositories repositories;
  SubmitKycUseCase(this.repositories);

  Future<void> call({required String name,required String email,required String profession,required String filePath,}) async {
    return repositories.submitKyc(name:name,email: email,profession: profession,filePath: filePath);
  }
}
