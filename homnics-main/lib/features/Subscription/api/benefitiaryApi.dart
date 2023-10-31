
import 'dart:convert';

import 'package:homnics/services/base_api.dart';
import 'package:http/http.dart';

import 'benefitiary_model.dart';

class BenefitiaryApi extends BaseAPI {
  //var url = '${baseUrl}${loginUrl}';
 Future<bool> addBenefitiary(BenefitiaryRequestModel benefitiaryRequestModel) async{
   var url = "https://api.homnics.com/user-api/plan/beneficiary";

   final param = json.encode(benefitiaryRequestModel.toJson());

   final response = await post(Uri.parse(url), headers: await myHeaders(), body: param);

    return true;
 }
}