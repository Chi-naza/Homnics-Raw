class ProfessionalResponse {
  String? id;
  dynamic professionalTypeId;
  String? applicationUserId;
  dynamic yearsOfExperience;
  dynamic professionalStatus;
  bool? isActive;
  String? dateAdded;
  String? dateModified;
  dynamic latitude;
  dynamic longitude;
  String? licenseType;
  String? title;
  String? languages;
  String? specialties;
  String? availableDays;
  bool? isVerified;
  dynamic gender;
  String? bio;
  bool? hasUploadedPhotoId;
  bool? hasUploadedLicence;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? avatar;
  String? photoIdUrl;
  String? licenceUrl;
  bool? isLicenseVerified;
  bool? isPhotoIdVerified;
  dynamic rating;

  ProfessionalResponse({
    required this.id,
    this.professionalTypeId,
    this.applicationUserId,
    this.yearsOfExperience,
    this.professionalStatus,
    this.isActive,
    this.dateAdded,
    this.dateModified,
    this.latitude,
    this.longitude,
    this.licenseType,
    this.title,
    this.languages,
    this.specialties,
    this.availableDays,
    this.isVerified,
    this.gender,
    this.bio,
    this.hasUploadedPhotoId,
    this.hasUploadedLicence,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.avatar,
    this.photoIdUrl,
    this.licenceUrl,
    this.isLicenseVerified,
    this.isPhotoIdVerified,
    this.rating,
  });

  ProfessionalResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    applicationUserId = json['applicationUserId']?.toString();
    professionalTypeId = json['professionalTypeId'];
    yearsOfExperience = json['yearsOfExperience'];
    professionalStatus = json['professionalStatus'];
    isActive = json['isActive'];
    dateAdded = json['dateAdded']?.toString();
    dateModified = json['dateModified']?.toString();
    latitude = json['latitude'];
    longitude = json['longitude'];
    licenseType = json['licenseType']?.toString();
    title = json['title']?.toString();
    languages = json['languages'];
    specialties = json['specialties'];
    availableDays = json['availableDays'];
    isVerified = json['isVerified'];
    gender = json['gender'];
    bio = json['bio']?.toString();
    hasUploadedPhotoId = json['hasUploadedPhotoId'];
    hasUploadedLicence = json['hasUploadedLicence'];
    name = json['name']?.toString();
    email = json['email']?.toString();
    phoneNumber = json['phoneNumber']?.toString();
    address = json['address']?.toString();
    avatar = json['avatar']?.toString();
    photoIdUrl = json['photoIdUrl']?.toString();
    licenceUrl = json['licenceUrl']?.toString();
    isLicenseVerified = json['isLicenseVerified'];
    isPhotoIdVerified = json['isPhotoIdVerified'];
    rating = json['rating'];
  }
}

class AllProfessional {
  List<ProfessionalResponse> professionals;

  AllProfessional({
    required this.professionals,
  });

  factory AllProfessional.fromJson(Map<String, dynamic> json) {
    var list = json['professionals'] as List;
    List<ProfessionalResponse> professionalList =
        list.map((i) => ProfessionalResponse.fromJson(i)).toList();

    return AllProfessional(professionals: professionalList);
  }
}
