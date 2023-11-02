import 'dart:convert';

import 'package:get/get.dart';
import 'package:homnics/features/professionals/models/professionals.dart';
import 'package:homnics/services/base_api.dart';
import 'package:http/http.dart';

import '../../../authentication/controller/authentication_controller.dart';
import '../../../services/constants.dart';
import '../models/all_professional_model.dart';

class ProfessionController {
  var authenticationController = Get.find<AuthenticationController>();

  Future<List<Professional>> apiGetAllProfessionalCall(
      {required int pageNumber,
      required int pageSize,
      required String searchParam}) async {
    var url = baseUrl + getProfessionalsUrl;

    try {
      final response = await get(Uri.parse(url),
          headers: await authenticationController.userHeader());

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result.containsKey('professionals')) {
          final List<Map<String, dynamic>> professionalDataList =
              List<Map<String, dynamic>>.from(result['professionals']);
          List<Professional> professionals = professionalDataList
              .map((data) => Professional.fromJson(data))
              .toList();

          if (professionals.isNotEmpty) {
            print("The length of professionals is : ${professionals.length}");
            print(
                "The name of the first professional is : ${professionals.first.name}");
          } else {
            print("No professionals found in the result.");
          }

          return professionals;
        } else {
          print("No 'professionals' key found in the API response.");
          return [];
        }
      } else {
        print("Request failed with status code: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("An error occurred while fetching professionals: $error");
      return [];
    }
  }
}
