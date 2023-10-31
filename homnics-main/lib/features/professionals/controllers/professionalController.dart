import 'dart:convert';

import 'package:get/get.dart';
import 'package:homnics/features/professionals/models/professionals.dart';
import 'package:homnics/services/base_api.dart';
import 'package:http/http.dart';

import '../../../authentication/controller/authentication_controller.dart';
import '../../../services/constants.dart';

class ProfessionController {
  var authenticationController = Get.find<AuthenticationController>();

  Future<List<Professional>> getProfessionals(
      {required int pageNumber,
      required int pageSize,
      required String searchParam}) async {
    var url = baseUrl + getProfessionalsUrl;
    // "?pageNumber=$pageNumber/?pageSize=$pageSize/searchParam=$searchParam";
    final response = await get(Uri.parse(url),
        headers: await authenticationController.userHeader());

    if (response.statusCode < 400) {
      var body = (json.decode(response.body))['professionals'];

      List<Professional> professionals =
          await Professional.professionalsFromJson(body);
      return professionals;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
