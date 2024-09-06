class UserModel {
  String id;
  String name;
  String email;
  String uniqueId;
  String mobileNumber;
  String designation;
  bool isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.uniqueId,
    required this.mobileNumber,
    required this.designation,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      uniqueId: json['uniqueId'],
      mobileNumber: json['mobileNumber'],
      designation: json['designation'],
      isVerified: json['isVerified'],
    );
  }
}
