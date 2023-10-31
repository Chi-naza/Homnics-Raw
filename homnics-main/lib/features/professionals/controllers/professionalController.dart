import 'dart:convert';

import 'package:homnics/features/professionals/models/professionals.dart';
import 'package:homnics/services/base_api.dart';
import 'package:http/http.dart';

import '../../../services/constants.dart';

class ProfessionController extends BaseAPI {
  Future<List<Professional>> getProfessionals(
      {required int pageNumber,
      required int pageSize,
      required String searchParam}) async {
    var url = baseUrl + getProfessionalsUrl;
    // "?pageNumber=$pageNumber/?pageSize=$pageSize/searchParam=$searchParam";
    final response = await get(Uri.parse(url), headers: await myHeaders());

    if (response.statusCode < 400) {
      var body = (json.decode(response.body))['professionals'];
      print(body);
      List<Professional> professionals =
          await Professional.professionalsFromJson(body);
      return professionals;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
