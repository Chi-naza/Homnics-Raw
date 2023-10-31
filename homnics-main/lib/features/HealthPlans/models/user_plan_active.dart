class UserPlanActive {
  final String planId;
  final Plan plan;
  final PlanDuration planDuration;
  final String startDate;
  final String endDate;
  final String createdDate;
  final String modifiedDate;
  final String paymentStatus;
  final bool status;

  UserPlanActive({
    required this.planId,
    required this.plan,
    required this.planDuration,
    required this.startDate,
    required this.endDate,
    required this.createdDate,
    required this.modifiedDate,
    required this.paymentStatus,
    required this.status,
  });

  factory UserPlanActive.fromJson(Map<String, dynamic> json) {
    return UserPlanActive(
      planId: json['planId'] ?? '',
      plan: Plan.fromJson(json['plan'] ?? {}),
      planDuration: PlanDuration.fromJson(json['planDuration'] ?? {}),
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      createdDate: json['createdDate'] ?? '',
      modifiedDate: json['modifiedDate'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      status: json['status'] ?? false,
    );
  }
}

class Plan {
  final int id;
  final String name;
  final String description;
  final double price;
  final int maxPerson;
  final double extraPersonPrice;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.maxPerson,
    required this.extraPersonPrice,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0.0,
      maxPerson: json['maxPerson'] ?? 0,
      extraPersonPrice: json['extraPersonPrice'] ?? 0.0,
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
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class UserplansActivePayload {
  final List<UserPlanActive> userPlans;

  UserplansActivePayload({
    required this.userPlans,
  });

  factory UserplansActivePayload.fromJson(Map<String, dynamic> json) {
    final userPlansList = (json['userPlans'] as List)
        .map((planJson) => UserPlanActive.fromJson(planJson))
        .toList();

    return UserplansActivePayload(userPlans: userPlansList);
  }
}
