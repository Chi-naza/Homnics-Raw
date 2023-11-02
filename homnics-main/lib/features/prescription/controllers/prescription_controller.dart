import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/prescription/controllers/prescription_response.dart';
import 'package:homnics/services/base_api.dart';
import 'package:http/http.dart';

import '../../../authentication/controller/authentication_controller.dart';
import '../../../services/constants.dart';

class PrescriptionController extends BaseAPI {
  var userPlanController = Get.find<UsersPlanController>();
  var authenticationController = Get.find<AuthenticationController>();

  getPrescriptionById(BuildContext context) async {
    String beneficiaryId = await userPlanController.getPlanBeneficiarId();
    var url = baseUrl + getPrescriptionsById(beneficiaryId);
    try {
      var response = await get(Uri.parse(url),
          headers: await authenticationController.userHeader());
      print(response.statusCode);
      var result = json.decode(response.body);

      print("result ::: $result");
      if (response.statusCode < 400) {
        print("loading");
        print(result);
        return result;
        //return Appointment.appointmentsFromJson(result['appointments']);
      }
    } catch (error) {
      print("The error is ::: ${error}");
      return [];
    }
  }

  Future<dynamic> fetchPrescriptions() async {
    try {
      String beneficiaryId = await userPlanController.getPlanBeneficiarId();
      final url = baseUrl + getPrescriptionsById(beneficiaryId);

      final response = await get(Uri.parse(url),
          headers: await authenticationController.userHeader());

      if (response.statusCode == 200) {
        print("Prescriptions fetched successfully.");

        var returnedData = jsonDecode(response.body);
        print(returnedData);
        return returnedData;
      } else {
        print("An error occurred: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred with error: $e");
    }
    return null;
  }
}
