import 'dart:convert';

import 'package:homnics/features/professionals/models/professionalType.dart';

import '../../auth/models/user.dart';

class Professional {
  String? id;
  String? professionalTypeId;
  ProfessionalType? professionalType;
  String? applicationUserId;
  User? user;
  int? yearsOfExperience;
  String? professionalStatus;
  bool? isActive;
  String? dateAdded;
  String? dateModified;
  String? latitude;
  String? longitude;
  String? licenseType;
  String? title;
  String? languages;
  String? specialties;
  String? availableDays;
  bool? isVerified;
  String? gender;
  String? bio;

  Professional({
    required this.id,
    this.professionalTypeId,
    this.professionalType,
    this.applicationUserId,
    this.user,
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
    professionalTypeId = json['professionalTypeId']?.toString();
    yearsOfExperience = int.parse(json['yearsOfExperience'].toString());
    professionalStatus = json['professionalStatus'].toString();
    isActive = json['isActive'];
    dateAdded = json['dateAdded']?.toString();
    dateModified = json['dateModified']?.toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    licenseType = json['licenseType']?.toString();
    title = json['title']?.toString();
    languages = json['languages'];
    specialties = json['specialties'];
    availableDays = json['availableDays'];
    isVerified = json['isVerified'];
    gender = json['gender'].toString();
    bio = json['bio']?.toString();
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
    prof.user = await User.getById(prof.applicationUserId!);
    prof.professionalType =
        await ProfessionalType.getById(prof.professionalTypeId!);
    return prof;
  }
}
