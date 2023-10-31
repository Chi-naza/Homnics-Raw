class UserRegisterResponseModel {
  final String userId;
  final String email;
  final String phone;
  final String created;

  UserRegisterResponseModel({
    required this.userId,
    required this.email,
    required this.phone,
    required this.created,
  });

  factory UserRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterResponseModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      created: json['created'] as String,
    );
  }
}
