class Meeting {
  final String planBeneficiaryJwt;
  final String professionalJwt;
  final String meetingLink;
  final DateTime dateCreated;
  final String appointmentId;

  Meeting({
    required this.planBeneficiaryJwt,
    required this.professionalJwt,
    required this.meetingLink,
    required this.dateCreated,
    required this.appointmentId,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      planBeneficiaryJwt: json['planBeneficiaryJwt'],
      professionalJwt: json['professionalJwt'],
      meetingLink: json['meetingLink'],
      dateCreated: DateTime.parse(json['dateCreated']),
      appointmentId: json['appointmentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'planBeneficiaryJwt': planBeneficiaryJwt,
      'professionalJwt': professionalJwt,
      'meetingLink': meetingLink,
      'dateCreated': dateCreated.toIso8601String(),
      'appointmentId': appointmentId,
    };
  }
}
