class UpdateUserRequestModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String city;
  final String country;
  final String postalCode;
  final String state;
  final DateTime dateOfBirth;
  final int gender;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final int emergencyContactRelationship;

  UpdateUserRequestModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
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

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "address": address,
      "city": city,
      "country": country,
      "postalCode": postalCode,
      "state": state,
      "dateOfBirth": dateOfBirth.toIso8601String(),
      "gender": gender,
      "emergencyContactName": emergencyContactName,
      "emergencyContactPhone": emergencyContactPhone,
      "emergencyContactRelationship": emergencyContactRelationship,
    };
  }
}
