class ProfileModel {
  String id;
  String displayName;
  String email;
  String phone;
  String? imageUrl;

  ProfileModel(
      {required this.displayName,
      required this.email,
      required this.phone,
      this.imageUrl,
      required this.id});

  factory ProfileModel.fromFirestore(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['uid'] ?? "",
        displayName: json['displayName'] ?? "",
        email: json['email'] ?? "",
        phone: json['phone'] ?? "",
        imageUrl: json['imageUrl']??"");
  }
  Map<String, dynamic> toJson() {
    return {
      id: 'uid',
      'displayName': displayName,
      'email': email,
      'phone': phone,
      'imageUrl':imageUrl
    };
  }
}
