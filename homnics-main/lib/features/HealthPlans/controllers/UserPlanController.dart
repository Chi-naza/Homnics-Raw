import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/authentication/controller/authentication_controller.dart';
import 'package:homnics/authentication/models/current_logged_in_user_model.dart';
import 'package:homnics/features/HealthPlans/models/user_plan_active.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/base_api.dart';
import '../../../services/constants.dart';
import '../models/user-plan.dart';

class UsersPlanController extends GetxController {
  final userPlanName = ''.obs;
  final planStartDate = ''.obs;

  // Base
  BaseAPI base = BaseAPI();

  // auth controller
  var auth = Get.find<AuthenticationController>();

  onReady() {
    getCurrentUserPlan();
    super.onReady();
  }

  Future<void> storeUserPlan(UserPlan userPlan) async {
    var url = baseUrl + postUserPlanUrl;

    SharedPreferences _pref = await SharedPreferences.getInstance();
    var ref = _pref.getString("payment_ref") ?? null;

    var params = json.encode({
      'userId': userPlan.userId,
      'planId': userPlan.healthPlanId,
      'planDurationId': userPlan.planDurationId,
      'startDate': userPlan.startDate,
      'startImmediately': userPlan.startImmediately,
      'paymentReference': ref,
    });
    final response = await post(Uri.parse(url),
        headers: await base.myHeaders(), body: params);

    // print(json.decode(response.body));
    if (response.statusCode == 200) {
      await _pref.setString("userplanId", userPlan.id ?? '');
      await _pref.setInt("userhealthPlanId", userPlan.healthPlanId);
      await _pref.setInt("userplan_planDurationId", userPlan.planDurationId);
      await _pref.setString("userplan_startDate", userPlan.startDate);
      await _pref.setBool(
          "userplan_startImmediately", userPlan.startImmediately);

      return;
    } else {
      print(Exception());
      print(response.statusCode);
      throw Exception('Failed to load data!');
    }
  }

  Future<String> getPlanBeneficiarId() async {
    var url = baseUrl + userPlanBeneficiaryUrl(await getActivePlanId());

    final response = await get(Uri.parse(url), headers: await base.myHeaders());
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      debugPrint("BENEFICIARY ID STATUS: ${response.statusCode}");
      // print(result['planBeneficiaries'][0]['id']);
      return result['planBeneficiaries'][0]['id'];
    } else {
      debugPrint("BENEFICIARY ID STATUS: ${response.statusCode}");
      throw Exception('Failed to load data!');
    }
  }

  getActivePlanId() async {
    CurrentLoggedInUserModel user = auth.userInfo.value;
    print("Active user Id :${user.userId}");

    var url = baseUrl + getActivePlanUrl(user.userId);
    var response = await get(Uri.parse(url), headers: await base.myHeaders());
    var result = json.decode(response.body);

    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString(
        "user_plan_strt_date", result['userPlans'][0]['startDate']);
    await _pref.setString(
        "user_plan_name", result['userPlans'][0]['plan']['name']);

    if (response.statusCode == 200) {
      debugPrint("ACTIVE PLAN STATUS: ${response.statusCode}");
      // updating our variable
      userPlanName.value = result['userPlans'][0]['plan']['name'];
      planStartDate.value = result['userPlans'][0]['startDate'];
      print(userPlanName);
      print(planStartDate);
      update();
      print(result['userPlans'][0].length);
      int length = result['userPlans'][0].length ?? 1;
      int index = length - 1;

      return result['userPlans'][0]['planId'];
    }
    debugPrint("ACTIVE PLANS GOTTEN STATUS: ${response.statusCode}");
  }

  Future<UserplansActivePayload?> getCurrentUserPlan() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = await _pref.getString("user_token") ?? '';

    CurrentLoggedInUserModel user = auth.userInfo.value;
    var url = baseUrl + getActivePlanUrl(user.userId);
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/vnd.api.v1+json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        debugPrint("USER PLAN: ${response.body}");
        debugPrint("USER PLAN STATUS: ${response.statusCode}");
        final Map<String, dynamic> json = jsonDecode(response.body);
        var returnResponse = UserplansActivePayload.fromJson(json);
        print("Returned : ${returnResponse.userPlans.first.planId}");
        // updating our variable
        userPlanName.value = returnResponse.userPlans.first.plan.name;
        planStartDate.value = returnResponse.userPlans.first.startDate;
        // Save to local
        await _pref.setString("health_plan_name", userPlanName.value);
        // Testing print outs
        print(userPlanName);
        print(planStartDate);
        return returnResponse;
      } else {
        print(
            "The request for PLAN DETAILS failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }

  Future<void> updateHealthPlan() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    int hasPlan = _pref.getInt("userhealthPlanId") ?? 0;
    print("::::Has Plan ${hasPlan}");
    // String hasPlan = hasPlan.toString();
    if (hasPlan > 0) {
      // check if plan is valid
      print("if plan is valid, I will let you in, else return to freemium");

      print(_pref.getString("user_plan_name") ?? 0);
      print(_pref.getInt("userhealthPlanId") ?? 0);
      openHome();
    } else {
      // createFreemium

      SharedPreferences _pref = await SharedPreferences.getInstance();
      await _pref.setInt("userhealthPlanId", 6);
      await _pref.setString("user_plan_name", "Freemium");
      userPlanName.value = "Freemium";
      CurrentLoggedInUserModel user = auth.userInfo.value;
      print(user.userId);
      print("::::::::::::::: not valid");

      UserPlan uPlan = UserPlan(
        userId: user.userId,
        healthPlanId: 6,
        planDurationId: 1,
        startDate: DateTime.now().toString(),
        startImmediately: true,
      );
      storeUserPlan(uPlan);
      openHome();
    }
  }

  openHome() {
    Navigator.of(Get.context!)
        .push(MaterialPageRoute(builder: (_) => NavigationScreen()));
  }
}
