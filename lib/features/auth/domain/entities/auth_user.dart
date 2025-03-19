class GoogleAuthUser {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  GoogleAuthUser(
      {required this.uid,
      required this.email,
      this.displayName,
      this.photoUrl});
}
