class Appointment {
  String? id;
  String? planBeneficiaryId;
  String? professionalId;
  dynamic? appointmentStatus;
  dynamic? appointmentFormat;
  String? appointmentDate;
  String? cancellationReason;
  String? symptoms;
  String? additionalInfo;
  String? beneficiaryRemindDate;
  String? professionalRemindDate;

  Appointment({
    this.id,
    this.planBeneficiaryId,
    this.professionalId,
    this.appointmentStatus,
    this.appointmentFormat,
    this.appointmentDate,
    this.cancellationReason,
    this.symptoms,
    this.additionalInfo,
    this.beneficiaryRemindDate,
    this.professionalRemindDate,
  });
  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    planBeneficiaryId = json['planBeneficiaryId']?.toString();
    professionalId = json['professionalId']?.toString();
    appointmentStatus = json['appointmentStatus'];
    appointmentFormat = json['appointmentFormat'];
    appointmentDate = json['appointmentDate']?.toString();
    cancellationReason = json['cancellationReason']?.toString();
    symptoms = json['symptoms']?.toString();
    additionalInfo = json['additionalInfo']?.toString();
    beneficiaryRemindDate = json['beneficiaryRemindDate']?.toString();
    professionalRemindDate = json['professionalRemindDate']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['planBeneficiaryId'] = planBeneficiaryId;
    data['professionalId'] = professionalId;
    data['appointmentStatus'] = appointmentStatus;
    data['appointmentFormat'] = appointmentFormat;
    data['appointmentDate'] = appointmentDate;
    data['cancellationReason'] = cancellationReason;
    data['symptoms'] = symptoms;
    data['additionalInfo'] = additionalInfo;
    data['beneficiaryRemindDate'] = beneficiaryRemindDate;
    data['professionalRemindDate'] = professionalRemindDate;
    return data;
  }

  static appointmentsFromJson(List<dynamic> appointments) {
    return appointments.map((e) => Appointment.fromJson(e)).toList();
  }
}
