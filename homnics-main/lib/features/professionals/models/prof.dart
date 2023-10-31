// import 'package:homnics/features/professionals/models/professionalType.dart';
//
// import '../../auth/models/user.dart';
//
// class Professional {
//   String id;
//   String? professionalTypeId;
//   ProfessionalType? professionalType;
//   String? applicationUserId;
//   User? user;
//   int? yearsOfExperience;
//   String? professionalStatus;
//   bool? isActive;
//   String? dateAdded;
//   String? dateModified;
//   String? latitude;
//   String? longitude;
//   String? licenseType;
//   String? title;
//   String? languages;
//   String? specialties;
//   String? availableDays;
//   bool? isVerified;
//   String? gender;
//   String? bio;
//
//   Professional({
//     required this.id,
//     this.professionalTypeId,
//     this.professionalType,
//     this.applicationUserId,
//     this.user,
//     this.yearsOfExperience,
//     this.professionalStatus,
//     this.isActive,
//     this.dateAdded,
//     this.dateModified,
//     this.latitude,
//     this.longitude,
//     this.licenseType,
//     this.title,
//     this.languages,
//     this.specialties,
//     this.availableDays,
//     this.isVerified,
//     this.gender,
//     this.bio,
//   });
//   Professional.fromJson(Map<String, dynamic> json) {
//     print("converting");
//     Professional prof = Professional(id: "error");
//     try {
//       prof = getFromJson(json);
//       print(prof.user!.firstName);
//     } catch (error) {
//       print(error.toString());
//     } finally {
//       return prof;
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['professionalTypeId'] = professionalTypeId;
//     data['applicationUserId'] = applicationUserId;
//     data['yearsOfExperience'] = yearsOfExperience;
//     data['professionalStatus'] = professionalStatus;
//     data['isActive'] = isActive;
//     data['dateAdded'] = dateAdded;
//     data['dateModified'] = dateModified;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['licenseType'] = licenseType;
//     data['title'] = title;
//     data['languages'] = languages;
//     data['specialties'] = specialties;
//     data['availableDays'] = availableDays;
//     data['isVerified'] = isVerified;
//     data['gender'] = gender;
//     data['bio'] = bio;
//     return data;
//   }
//
//   static professionalsFromJson(List<dynamic> professionals) {
//     return professionals.map((e) => Professional.fromJson(e)).toList();
//   }
//
//   static Future<Professional> getFromJson(Map<String, dynamic> json) async {
//     var prof = Professional(
//       id: json['id'].toString(),
//       user: await User.getById(json['applicationUserId'].toString()),
//       professionalType:
//           await ProfessionalType.getById(json['professionalTypeId'].toString()),
//       professionalTypeId: json['professionalTypeId']?.toString(),
//       applicationUserId: json['applicationUserId']?.toString(),
//       yearsOfExperience: int.parse(json['yearsOfExperience'].toString()),
//       professionalStatus: json['professionalStatus'].toString(),
//       isActive: json['isActive'],
//       dateAdded: json['dateAdded']?.toString(),
//       dateModified: json['dateModified']?.toString(),
//       latitude: json['latitude'].toString(),
//       longitude: json['longitude'].toString(),
//       licenseType: json['licenseType']?.toString(),
//       title: json['title']?.toString(),
//       languages: json['languages'],
//       specialties: json['specialties'],
//       availableDays: json['availableDays'],
//       isVerified: json['isVerified'],
//       gender: json['gender'].toString(),
//       bio: json['bio']?.toString(),
//     );
//
//     return prof;
//   }
// }
