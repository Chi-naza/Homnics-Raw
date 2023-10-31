// To parse this JSON data, do
//
//     final healthplanModel = healthplanModelFromJson(jsonString);

import 'dart:convert';

HealthPlan healthplanModelFromJson(String str) =>
    HealthPlan.fromJson(json.decode(str));

String healthplanModelToJson(HealthPlan data) => json.encode(data.toJson());

// how to convert json to a list of model
class HealthPlan {
  HealthPlan({
     this.id,
     this.name,
     this.description,
     this.price,
     this.maxPerson,
     this.extraPersonPrice,
  });

  int? id;
  String? name;
  String? description;
  double? price;
  int? maxPerson;
  double? extraPersonPrice;

  factory HealthPlan.fromJson(Map<String, dynamic> json) => HealthPlan(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        maxPerson: json["maxPerson"],
        extraPersonPrice: json["extraPersonPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "maxPerson": maxPerson,
        "extraPersonPrice": extraPersonPrice,
      };

  static healthPlansFromJson(List<dynamic> products) {
    return products.map((e) => HealthPlan.fromJson(e)).toList();
  }
}
