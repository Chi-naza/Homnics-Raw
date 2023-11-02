class CreateBeneficiaryRequestModel {
  final String userPlanId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String suffix;
  final int gender;
  final DateTime dateOfBirth;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String phoneNumber;
  final String email;
  final String country;

  CreateBeneficiaryRequestModel({
    required this.userPlanId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.suffix,
    required this.gender,
    required this.dateOfBirth,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phoneNumber,
    required this.email,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      "userPlanId": userPlanId,
      "firstName": firstName,
      "lastName": lastName,
      "middleName": middleName,
      "suffix": suffix,
      "gender": gender,
      "dateOfBirth": dateOfBirth.toIso8601String(),
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "city": city,
      "state": state,
      "zipCode": zipCode,
      "phoneNumber": phoneNumber,
      "email": email,
      "country": country,
    };
  }
}
