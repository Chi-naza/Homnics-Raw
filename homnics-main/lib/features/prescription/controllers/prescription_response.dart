class Prescription {
  final String id;
  final String beneficiaryName;
  final String professionalName;
  final List<Medication> medications;

  Prescription({
    required this.id,
    required this.beneficiaryName,
    required this.professionalName,
    required this.medications,
  });
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
}
