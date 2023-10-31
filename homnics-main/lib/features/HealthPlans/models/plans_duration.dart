class HealthPlan {
  final int id;
  final String name;
  final String description;
  final double price;
  final int maxPerson;
  final double extraPersonPrice;

  HealthPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.maxPerson,
    required this.extraPersonPrice,
  });

  factory HealthPlan.fromJson(Map<String, dynamic> json) {
    return HealthPlan(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      maxPerson: json['maxPerson'] as int,
      extraPersonPrice: json['extraPersonPrice'] as double,
    );
  }
}

class PlanDuration {
  final int id;
  final String name;
  final String description;

  PlanDuration({
    required this.id,
    required this.name,
    required this.description,
  });

  factory PlanDuration.fromJson(Map<String, dynamic> json) {
    return PlanDuration(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}


class PlanResponseModel {
  final List<HealthPlan> healthPlans;
  final List<PlanDuration> planDurations;

  PlanResponseModel({
    required this.healthPlans,
    required this.planDurations,
  });

  factory PlanResponseModel.fromJson(Map<String, dynamic> json) {
    final healthPlansJson = json['healthPlans'] as List<dynamic>;
    final planDurationsJson = json['planDurations'] as List<dynamic>;

    final healthPlans = healthPlansJson
        .map((plan) => HealthPlan.fromJson(plan as Map<String, dynamic>))
        .toList();

    final planDurations = planDurationsJson
        .map((duration) => PlanDuration.fromJson(duration as Map<String, dynamic>))
        .toList();

    return PlanResponseModel(
      healthPlans: healthPlans,
      planDurations: planDurations,
    );
  }
}