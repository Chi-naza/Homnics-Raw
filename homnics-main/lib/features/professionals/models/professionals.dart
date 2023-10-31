import 'dart:convert';

import 'package:homnics/features/professionals/models/professionalType.dart';

import '../../auth/models/user.dart';

class Professional {
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

  Professional({
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

  List<String> get getAvailability {
    List<String> convertedList =
        jsonDecode(this.availableDays ?? '').cast<String>();
    return convertedList;
  }

  get getSpecialities {
    List<String> convertedList =
        jsonDecode(this.specialties ?? '').cast<String>();
    convertedList.map((item) => item).join(', ');
    return convertedList.map((item) => item).join(', ');
  }

  List get getLanguages {
    List<String> convertedList =
        jsonDecode(this.languages ?? '').cast<String>();
    return convertedList;
  }

  Professional.fromJson(Map<String, dynamic> json) {
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

  //
  // Future<void> populateUserAndType() async {
  //   user = await User.getById(applicationUserId!);
  //   professionalType = await ProfessionalType.getById(professionalTypeId!);
  // }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['professionalTypeId'] = professionalTypeId;
    data['applicationUserId'] = applicationUserId;
    data['yearsOfExperience'] = yearsOfExperience;
    data['professionalStatus'] = professionalStatus;
    data['isActive'] = isActive;
    data['dateAdded'] = dateAdded;
    data['dateModified'] = dateModified;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['licenseType'] = licenseType;
    data['title'] = title;
    data['languages'] = languages;
    data['specialties'] = specialties;
    data['availableDays'] = availableDays;
    data['isVerified'] = isVerified;
    data['gender'] = gender;
    data['bio'] = bio;
    return data;
  }

  static Future<List<Professional>> professionalsFromJson(
      List<dynamic> professionals) async {
    List<Professional> allProfessionals = [];
    List<Future<Professional>> futures =
        professionals.map((e) => getProfessionalJson(e)).toList();
    List<Professional> results = await Future.wait(futures);
    allProfessionals.addAll(results);
    return allProfessionals;
  }

  static Future<Professional> getProfessionalJson(
      Map<String, dynamic> json) async {
    var prof = Professional.fromJson(json);
    prof = await User.getById(prof.applicationUserId!);
    prof = await ProfessionalType.getById(prof.professionalTypeId.toString());
    return prof;
  }
}
