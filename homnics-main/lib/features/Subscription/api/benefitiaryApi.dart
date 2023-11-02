import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../authentication/controller/authentication_controller.dart';
import '../../../services/constants.dart';
import 'create_beneficiary_request_model.dart';

class BenefitiaryController {
  var authenticationController = Get.find<AuthenticationController>();

  Future<void> makePostRequest(
      CreateBeneficiaryRequestModel createBeneficiaryRequestModel) async {
    final url = Uri.parse('https://api.homnics.com/user-api/plan/beneficiary');

    try {
      final response = await http.post(
        url,
        headers: await authenticationController.userHeader(),
        body: json.encode(createBeneficiaryRequestModel.toJson()),
      );
      print(response.body);
      if (response.statusCode == 200) {
        print('POST request successful!');

        authenticationController.aPiSnackBar("Beneficiary Added!");
        print('Response: ${response.body}');
        print('Response Status Code ${response.statusCode}');

        // final route =
        //     MaterialPageRoute(builder: (context) => BenefitiaryListScreen());
        // Navigator.push(context, route);

        // You can return the response data if needed, e.g., BeneficiaryResponseModel.fromJson(jsonDecode(response.body));
      } else {
        print('POST request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error making POST request: $error');
      // You can throw an exception or handle the error as needed.
    }
  }

  // Future<UserPlanHistoryResponseModel> getUserPlansHistory() async {
  //   var (userId, email, password, token) =
  //       await authenticationController.fetchUserData();

  //   var url = baseUrl + getUserPlansHistoryUrl(userId);
  //   try {
  //     final response = await get(
  //       Uri.parse(url),
  //       headers: await {
  //         'Accept': 'application/vnd.api.v1+json',
  //         'Content-Type': 'Application/json',
  //         "Authorization": "Bearer $token",
  //       },
  //     );
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> json = jsonDecode(response.body);

  //       var returnedData = UserPlanHistoryResponseModel.fromJson(json);
  //       print("RETURNED DATA : $returnedData");
  //       return returnedData;
  //     } else {
  //       throw Exception('Empty response: No user data available.');
  //     }
  //   } catch (e) {
  //     // Handle exceptions (e.g., network errors) here.
  //     print('Error: $e');
  //     return throw (e);
  //   }
  // }
}
