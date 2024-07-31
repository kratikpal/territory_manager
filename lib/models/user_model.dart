class UserModel {
  String id;
  String name;
  String email;
  String uniqueId;
  bool isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.uniqueId,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      uniqueId: json['uniqueId'],
      isVerified: json['isVerified'],
    );
  }
}

