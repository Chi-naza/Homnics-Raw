import 'dart:convert';

import 'package:http/http.dart';

import '../../../services/base_api.dart';
import '../../../services/constants.dart';
import '../models/professionalType.dart';

class ProfessionalTypeController extends BaseAPI {
  getTypeById(String professionalTypeId) async {
    var url = baseUrl + getProfessionalTypeById(professionalTypeId);

    final response = await get(Uri.parse(url), headers: await myHeaders());

    if (response.statusCode < 400) {
      var body = (json.decode(response.body));
      var professionalType = ProfessionalType.fromJson(body);

      return professionalType;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
