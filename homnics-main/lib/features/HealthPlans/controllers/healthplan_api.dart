import 'dart:convert';

import 'package:homnics/services/base_api.dart';
import 'package:homnics/services/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/health_plan_model.dart';
import '../models/user-plan.dart';

class HealthPlanApi extends BaseAPI {
  Future<List<HealthPlan>> gethealthplans() async {
    var url = baseUrl + 'user-api/plan/health-plans';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode < 400) {
      var plans = HealthPlan.healthPlansFromJson(
          jsonDecode(response.body)["healthPlans"]);
      return plans;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // saveUserPlan({required HealthPlan plan}) {}

  // Future<HealthPlan?> getByHealthPlanById() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //    var userHealthPlanid = _pref.getInt("userhealthPlanId");

  //   String remoteHealthPlanUrl = 'https://api.homnics.com/user-api/plan/$userHealthPlanid';
  //   try {
  //     final response = await http.get(Uri.parse(remoteHealthPlanUrl));
  //     print(response.body);
  //     if (response.statusCode == 200) {

  //       final json = jsonDecode(response.body);
  //       var returedData = HealthPlan.fromJson(json['healthPlans']);
  //       print(returedData);

  //       return returedData;
  //     } else {
  //       print("The returned data is empty");
  //       // Handle non-200 status code here, e.g., throw an exception or return an error message.
  //       return null;
  //     }
  //   } catch (e) {
  //     // Handle exceptions (e.g., network errors) here.
  //     print('Error: $e');
  //     return null;
  //   }
  // }
}
