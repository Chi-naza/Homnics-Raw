class CurrentLoggedInUserModel {
  final String userId;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String fullName;
  final String avatar;
  final bool isActive;
  final String identityDocument;
  final String professionalLicence;
  final List<String> permissions;
  final String address;
  final String city;
  final String country;
  final String postalCode;
  final String state;
  final DateTime dateOfBirth;
  final String gender;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyContactRelationship;

  CurrentLoggedInUserModel({
    required this.userId,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.avatar,
    required this.isActive,
    required this.identityDocument,
    required this.professionalLicence,
    required this.permissions,
    required this.address,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.state,
    required this.dateOfBirth,
    required this.gender,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.emergencyContactRelationship,
  });

  factory CurrentLoggedInUserModel.fromJson(Map<String, dynamic> json) {
    final List<String> permissionsList =
        (json['permissions'] as List).cast<String>();
    return CurrentLoggedInUserModel(
      userId: json['userId'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      fullName: json['fullName'] ?? "",
      avatar: json['avatar'] ?? "",
      isActive: json['isActive'] as bool,
      identityDocument: json['identityDocument'] ?? "",
      professionalLicence: json['professionalLicence'] ?? "",
      permissions: permissionsList,
      address: json['address'] ?? "",
      city: json['city'] ?? "",
      country: json['country'] ?? "",
      postalCode: json['postalCode'] ?? "",
      state: json['state'] ?? "",
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'] ?? '',
      emergencyContactName: json['emergencyContactName'] ?? "",
      emergencyContactPhone: json['emergencyContactPhone'] ?? "",
      emergencyContactRelationship: json['emergencyContactRelationship'] ?? '',
    );
  }
}
