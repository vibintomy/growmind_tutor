class Profile {
  String uid;
  String displayName;
  String email;
  String phone;
  String? imageUrl;
  Profile(
      {required this.displayName,
      required this.email,
      required this.phone,
      required this.uid,
      this.imageUrl});
}
