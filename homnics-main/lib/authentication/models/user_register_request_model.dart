class UserRegisterRequestModel {
  final String email;
  final String phone;
  final String password;
  final int permission;

  UserRegisterRequestModel({
    required this.email,
    required this.phone,
    required this.password,
    required this.permission,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "phone": phone,
      "password": password,
      "permission": permission,
    };
  }
}
