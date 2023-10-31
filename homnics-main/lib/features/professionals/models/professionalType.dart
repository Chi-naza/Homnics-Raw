import '../controllers/professionalTypeController.dart';

class ProfessionalType {
  String id;
  String name;
  String description;
  bool isActive;
  String dateAdded;
  String dateModified;

  ProfessionalType({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.dateAdded,
    required this.dateModified,
  });
  factory ProfessionalType.fromJson(Map<String, dynamic> json) {
    ProfessionalType type = ProfessionalType(
        id: '',
        name: '',
        description: '',
        isActive: true,
        dateAdded: '',
        dateModified: '');
    try {
      type = ProfessionalType(
        id: json['id'].toString(),
        name: json['name'].toString(),
        description: json['description'].toString(),
        isActive: json['isActive'],
        dateAdded: json['dateAdded'].toString(),
        dateModified: json['dateModified'].toString(),
      );
      print(type.name);
    } catch (error) {
      print(error.toString());
    } finally {
      return type;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['isActive'] = isActive;
    data['dateAdded'] = dateAdded;
    data['dateModified'] = dateModified;
    return data;
  }

  static professionalTypesFromJson(List<dynamic> professionalTypes) {
    return professionalTypes.map((e) => ProfessionalType.fromJson(e)).toList();
  }

  static getById(String professionalTypeId) async {
    ProfessionalType type = ProfessionalType(
      id: '',
      name: '',
      description: '',
      isActive: true,
      dateAdded: '',
      dateModified: '',
    );
    try {
      type = await ProfessionalTypeController().getTypeById(professionalTypeId);
    } catch (error) {
      print(error.toString());
    } finally {
      return type;
    }
  }
}
