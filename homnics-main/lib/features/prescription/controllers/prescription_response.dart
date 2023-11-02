class Prescription {
  final String id;
  final String planBeneficiaryId;
  final String professionalId;
  final String appointmentId;
  final List<Medication> medications;
  final String beneficiaryName;
  final String beneficiaryDateOfBirth;
  final String dateAdded;
  final String beneficiaryGender;
  final String symptoms;
  final String beneficiaryNumber;
  final String avatar;
  final String professionalName;
  final String professionalSpecialties;
  final String professionalAvatar;
  final String professionalNumber;
  final String professionalEmail;
  final String professionalTitle;
  final int professionalYearsOfExperience;
  final double professionalRating;
  final String professionalGender;

  Prescription({
    required this.id,
    required this.planBeneficiaryId,
    required this.professionalId,
    required this.appointmentId,
    required this.medications,
    required this.beneficiaryName,
    required this.beneficiaryDateOfBirth,
    required this.dateAdded,
    required this.beneficiaryGender,
    required this.symptoms,
    required this.beneficiaryNumber,
    required this.avatar,
    required this.professionalName,
    required this.professionalSpecialties,
    required this.professionalAvatar,
    required this.professionalNumber,
    required this.professionalEmail,
    required this.professionalTitle,
    required this.professionalYearsOfExperience,
    required this.professionalRating,
    required this.professionalGender,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    final List<dynamic> medicationsJson = json['medications'] ?? [];
    final List<Medication> medications = medicationsJson.map((medicationJson) {
      return Medication.fromJson(medicationJson);
    }).toList();

    return Prescription(
      id: json['id'],
      planBeneficiaryId: json['planBeneficiaryId'],
      professionalId: json['professionalId'],
      appointmentId: json['appointmentId'],
      medications: medications,
      beneficiaryName: json['beneficiaryName'],
      beneficiaryDateOfBirth: json['beneficiaryDateOfBirth'],
      dateAdded: json['dateAdded'],
      beneficiaryGender: json['beneficiaryGender'],
      symptoms: json['symptoms'],
      beneficiaryNumber: json['beneficiaryNumber'],
      avatar: json['avatar'],
      professionalName: json['professionalName'],
      professionalSpecialties: json['professionalSpecialties'],
      professionalAvatar: json['professionalAvatar'],
      professionalNumber: json['professionalNumber'],
      professionalEmail: json['professionalEmail'],
      professionalTitle: json['professionalTitle'],
      professionalYearsOfExperience: json['professionalYearsOfExperience'],
      professionalRating: json['professionalRating'],
      professionalGender: json['professionalGender'],
    );
  }
}

class Medication {
  final String medicationId;
  final String dosage;
  final String format;
  final String instruction;

  Medication({
    required this.medicationId,
    required this.dosage,
    required this.format,
    required this.instruction,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      medicationId: json['medicationId'],
      dosage: json['dosage'],
      format: json['format'],
      instruction: json['instruction'],
    );
  }
}
