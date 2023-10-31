import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:homnics/features/payments/controllers/payment_API_Service.dart';

import '../../HealthPlans/models/health_plan_model.dart';
import '../views/payment_webview.dart';

class PaymentController {
  verifyTransaction(ref) {}

  showPaystack(
      {required String title,
      required HealthPlan plan,
      required double amount,
      required String email,
      required BuildContext context}) async {
    var _ref = await PaymentAPIService()
            .getPaymentReference(email: email, healthPlanId: plan.id!) ??
        'Homnics_${DateTime.now().millisecondsSinceEpoch}';

    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('payment_ref', _ref);

    Map data = {
      // Removing the kobo by multiplying with 100
      "amount": double.parse('${amount * 100}').toInt(),
      "email": email,
      "reference": _ref,
      "callback_url": "https://github.com/ujahmycine", //"https://homnics.com/",
      "metadata": {"cancel_action": "https://homnics.com/"}
    };

    String authUrl = await makeAPICall(data);

    if (authUrl.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => WebViewExample(
            healthPlan: plan,
            title: title,
            email: email,
            authUrl: authUrl,
            ref: _ref,
          ),
        ),
      );
    }
  }

  makeAPICall(Map data) async {
    return await PaymentAPIService().authorizeUrl(data);
  }
}
