class Symptom {
  String id;
  String description;

  Symptom({
    required this.id,
    required this.description,
  });

  static List<Symptom> symptoms = [
    Symptom(id: "1", description: "Headache"),
    Symptom(id: "2", description: "Crazy"),
    Symptom(id: "3", description: "Over Excited"),
    Symptom(id: "4", description: "Stomach-ache"),
    Symptom(id: "5", description: "Sleepy"),
    Symptom(id: "6", description: "Tired"),
    Symptom(id: "7", description: "Faint"),
    Symptom(id: "8", description: "Fever"),
    Symptom(id: "9", description: "Bleeding"),
    Symptom(id: "10", description: "Frequent Stooling"),
  ];
}
