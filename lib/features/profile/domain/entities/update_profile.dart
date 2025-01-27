class UpdateProfile {
  final String id;
  final String name;
  final String phone;
  final String? imageUrl;

  UpdateProfile(
      {required this.id,
      required this.name,
      required this.phone,
       this.imageUrl});
}
