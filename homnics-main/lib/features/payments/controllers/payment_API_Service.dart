import 'dart:convert';

import 'package:homnics/services/base_api.dart';
import 'package:homnics/services/constants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentAPIService extends BaseAPI {
  getPayStackToken() {
    return "Bearer sk_test_04eaa3bcfa69edcbdce6ae2c4370a73786f6bb25";
  }

  authorizeUrl(Map data) async {
    var url = getPaystackAuthUrl;
    final param = json.encode(data);
    var headers = <String, String>{
      'Content-Type': 'text/plain',
      'Authorization': getPayStackToken(),
    };

    final response = await post(Uri.parse(url), headers: headers, body: param);

    print(json.decode(response.body));
    print(response.statusCode);
    if (response.statusCode < 400) {
      return json.decode(response.body)['data']['authorization_url'];
    }
    return '';
  }

  getPaymentReference(
      {required int healthPlanId, required String email}) async {
    var url = baseUrl + getPaymentReferenceUrl;
    final param = json.encode({"healthPlanId": healthPlanId, "email": email});

    SharedPreferences _pref = await SharedPreferences.getInstance();

    String token = await _pref.getString("user_token") ?? '';
    final response = await post(Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'Application/json',
          "Authorization": "Bearer $token",
        },
        body: param);
    print(response.body);
    // var decodedJson = json.decode(response.body);
    // print(decodedJson);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body)['paymentReference'];
    }

    return null;
  }

  verifyTransaction(String reference) async {
    var url = verifyTransactionUrl(reference);
    var headers = <String, String>{
      'Content-Type': 'text/plain',
      'Authorization': getPayStackToken(),
    };

    final response = await get(
      Uri.parse(url),
      headers: headers,
    );

    var body = json.decode(response.body);
    if (response.statusCode < 400) {
      //save the content of the response
      body = body['data'];
      print(body);
      SharedPreferences _pref = await SharedPreferences.getInstance();
      await _pref.setInt('payment_id', body['id']);
      await _pref.setString('payment_domain', body['domain']);
      await _pref.setString('payment_status', body['status']);
      await _pref.setString('payment_reference', body['reference']);
      await _pref.setInt('payment_amount', body['amount']);
      await _pref.setString('payment_date', body['paid_at']);
      await _pref.setString('payment_channel', body['channel']);
      await _pref.setString('payment_currency', body['currency']);
      await _pref.setString('payment_ip', body['ip_address']);
      await _pref.setInt('payment_charge', body['fees']);
      await _pref.setString('payment_last4', body['authorization']['last4']);
      await _pref.setString(
          'payment_exp_month', body['authorization']['exp_month']);
      await _pref.setString(
          'payment_exp_year', body['authorization']['exp_year']);

      print(body);
      return true;
    }
    return false;
  }
}
