

abstract class TutorRepositories {
  Future<String> uploadPdf(String filePath);
  Future<void> submitKyc({ required String name,required String email,required String profession,required String filePath});
}
