class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String phone;
  UserModel({required this.id, required this.email, required this.displayName,required this.phone});

  factory UserModel.fromFirebaseUser(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'], email: json['email'], displayName: json['displayName'],phone: json['phone']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'phone':phone
    };
  }
}
