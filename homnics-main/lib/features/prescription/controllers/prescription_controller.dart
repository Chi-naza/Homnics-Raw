import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/prescription/controllers/prescription_response.dart';
import 'package:homnics/services/base_api.dart';
import 'package:http/http.dart';

import '../../../services/constants.dart';

class PrescriptionController extends BaseAPI {
  var userPlanController = Get.find<UsersPlanController>();

  getPrescriptionById(BuildContext context) async {
    String beneficiaryId = await userPlanController.getPlanBeneficiarId();
    var url = baseUrl + getPrescriptionsById(beneficiaryId);
    try {
      var response = await get(Uri.parse(url), headers: await myHeaders());
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

  Future<Prescription?> fetchPrescriptions(BuildContext context) async {
    try {
      String beneficiaryId = await userPlanController.getPlanBeneficiarId();
      final url = baseUrl + getPrescriptionsById(beneficiaryId);

      final response =
          await get(Uri.parse(url), headers: await BaseAPI().myHeaders());

      if (response.statusCode == 200) {
        // Successful response
        print("Prescriptions fetched successfully.");
        final responsePrescription =
            jsonDecode(response.body) as Map<String, dynamic>;
        final prescription = Prescription(
          id: responsePrescription['id'],
          beneficiaryName: responsePrescription['beneficiaryName'],
          professionalName: responsePrescription['professionalName'],
          medications: (responsePrescription['medications'] as List)
              .map((medicationJson) => Medication(
                    medicationId: medicationJson['medicationId'],
                    dosage: medicationJson['dosage'],
                    format: medicationJson['format'],
                    instruction: medicationJson['instruction'],
                  ))
              .toList(),
        );
      } else if (response.statusCode == 404) {
        // Handle 404 status code (Resource not found)
        print("Prescriptions not found for the beneficiary.");
        // Display a user-friendly message to indicate no prescriptions found.
      } else {
        // Handle other error status codes here
        print("An error occurred: ${response.statusCode}");
        // Display a generic error message or implement other appropriate actions.
      }
    } catch (e) {
      // Handle any other exceptions that might occur during the process
      print("An error occurred with error: $e");
      // Display a generic error message or implement other appropriate actions.
    }
    return null;
  }
}
