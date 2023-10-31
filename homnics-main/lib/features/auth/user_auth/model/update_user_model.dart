class UpdateResponseModel {
  final String token;
  final String error;
  final String userId;

  UpdateResponseModel({required this.token, required this.error,  required this.userId});

  factory UpdateResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateResponseModel(
      token: json["userId"] != null ? json["userId"] : "",
      error: json["error"] != null ? json["error"] : "",
      userId: json["userId"] != null ? json["userId"] : "",

    );
  }
   void printAttributes() {
    print("id: ${this.userId}\n");
   
    print("token: ${this.token}\n");
  }
}

class UpdateRequestModel {
  String ?firstName;
  String ?lastName;
  String ?address;
  String ?phone;
  String ?city;
  String ?state;
  String ?country;
  String ?postalCode;
  String ?dateOfBirth;
  String ?emergencyContactName;
  String ?emergencyContactPhone;
  String ?gender;
  String ?emergencyContactRelationship;

  
  UpdateRequestModel({
    this.firstName,
    this.lastName,
     this.address,
     this.phone,
     this.city,
     this.state,
     this.country,
     this.postalCode,
     this.dateOfBirth,
     this.emergencyContactName,
     this.emergencyContactPhone,
     this.gender, 
     this.emergencyContactRelationship, 
    
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'firstName' : firstName?.trim(),
      'lastName' : lastName?.trim(),
      'address': address?.trim(),
      'phoneNumber': phone?.trim(),
      'city' : city?.trim(),
      'state' : state?.trim(),
      'country' : country?.trim(),
      'postalCode' : postalCode?.trim(),
      'dateOfBirth' : dateOfBirth?.trim(),
      'emergencyContactName': emergencyContactName?.trim(),
      'emergencyContactPhone': emergencyContactPhone?.trim(),
      'gender': gender?.trim(),
      'emergencyContactRelationship': emergencyContactRelationship?.trim(),

     
    };

    return map;
  }
}
