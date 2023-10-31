class UserPlanResponse {
    String planId;
    // Plan plan;
    // PlanDuration planDuration;
    String startDate;
    String endDate;
    String createdDate;
    String modifiedDate;
    //int paymentStatus;
    bool status;

    UserPlanResponse({
        required this.planId,
        // required this.plan,
        // required this.planDuration,
        required this.startDate,
        required this.endDate,
        required this.createdDate,
        required this.modifiedDate,
        //required this.paymentStatus,
        required this.status,
    });

    Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['planId'] = planId;
    data['endDate'] = endDate;
    data['createdDate'] = createdDate;
    data['startDate'] = startDate;
    data['modifiedDate'] = modifiedDate;
    data['status'] = status;
    return data;
  }
  
}