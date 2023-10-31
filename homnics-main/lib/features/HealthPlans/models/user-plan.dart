// "userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
// "planId": 50,
// "planDurationId": 10,
// "startDate": "2023-05-01",
// "startImmediately": true
//
//
//
//
// {
// "userPlanId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
// "paymentStatus": 0
// }

class UserPlan {
  String? id;
  String userId;
  int healthPlanId;
  int planDurationId;
  String startDate;
  bool startImmediately;

  UserPlan({
    this.id,
    required this.userId,
    required this.healthPlanId,
    required this.planDurationId,
    required this.startDate,
    required this.startImmediately,
  });

  factory UserPlan.fromJson(Map<String, dynamic> json) => UserPlan(
        id: json['userId'],
        healthPlanId: json['planId'],
        planDurationId: json['planDurationId'],
        startDate: json['startDate'],
        startImmediately: json['startImmediately'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['healthPlanId'] = healthPlanId;
    data['planDurationId'] = planDurationId;
    data['startDate'] = startDate;
    data['startImmediately'] = startImmediately;
    return data;
  }
}
