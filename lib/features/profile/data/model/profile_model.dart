class ProfileModel {
  String id;
  String displayName;
  String email;
  String phone;

  ProfileModel(
      {required this.displayName, required this.email, required this.phone,required this.id});

  factory ProfileModel.fromFirestore(Map<String, dynamic> json) {
    return ProfileModel(
       id: json['uid']??"",
        displayName: json['displayName'] ?? "",
        email: json['email'] ?? "",
        phone: json['phone'] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {id:'uid','displayName': displayName, 'email': email, 'phone': phone};
  }
}
