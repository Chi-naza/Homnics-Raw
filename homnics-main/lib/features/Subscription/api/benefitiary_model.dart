

// BenefitiaryRequestModel benefitiaryRequestModelFromJson(String str) => BenefitiaryRequestModel.fromJson(json.decode(str));

// String benefitiaryRequestModelToJson(BenefitiaryRequestModel data) => json.encode(data.toJson());

class BenefitiaryRequestModel {
    String ?userPlanId;
    String ?firstName;
    String ?lastName;
    String ?middleName;
    String ?suffix;
    int ?gender;
    DateTime ?dateOfBirth;
    String ?addressLine1;
    String ?addressLine2;
    String ?city;
    String ?state;
    String ?zipCode;
    String ?phoneNumber;
    String ?email;
    String ?country;

    BenefitiaryRequestModel({
         this.userPlanId,
         this.firstName,
         this.lastName,
         this.middleName,
         this.suffix,
         this.gender,
         this.dateOfBirth,
         this.addressLine1,
         this.addressLine2,
         this.city,
         this.state,
         this.zipCode,
         this.phoneNumber,
         this.email,
         this.country,
    });

    factory BenefitiaryRequestModel.fromJson(Map<String, dynamic> json) => BenefitiaryRequestModel(
        userPlanId: json["userPlanId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        suffix: json["suffix"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "userPlanId": userPlanId?.trim(),
        "firstName": firstName?.trim(),
        "lastName": lastName?.trim(),
        "middleName": middleName?.trim(),
        "suffix": suffix?.trim(),
        "gender": gender,
        "dateOfBirth": "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
        "addressLine1": addressLine1?.trim(),
        "addressLine2": addressLine2?.trim(),
        "city": city?.trim(),
        "state": state?.trim(),
        "zipCode": zipCode?.trim(),
        "phoneNumber": phoneNumber?.trim(),
        "email": email?.trim(),
        "country": country?.trim(),
    };
}
