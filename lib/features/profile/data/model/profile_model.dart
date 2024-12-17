class ProfileModel {
  String displayName;
  String email;
  String phone;


  ProfileModel({required this.displayName, required this.email,required this.phone});

  factory ProfileModel.fromFirestore(Map<String, dynamic> json) {
    return ProfileModel(displayName: json['displayName']?? "", email: json['email']??"",phone: json['phone']??"");
  }
  Map<String, dynamic> toJson() {
    return {'displayName': displayName, 'email': email,'phone':phone};
  }
}
