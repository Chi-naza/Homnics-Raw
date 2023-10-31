// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:homnics/features/payments/controllers/payment_API_Service.dart';
// import 'package:homnics/features/payments/views/payment_webview.dart';
// import 'package:http/http.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class testPayment2 extends StatefulWidget {
//   const testPayment2({Key? key}) : super(key: key);
//
//   @override
//   State<testPayment2> createState() => _testPayment2State();
// }
//
// class _testPayment2State extends State<testPayment2> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: () {
//           _showPaystack();
//         },
//         child: Text("Pay"));
//   }
//
//   _showPaystack() async {
//     double _amount = 3500;
//     String email = "ujahmycine@gmail.com";
//
//     var _ref = 'ChargedFromMyApp_${DateTime.now().millisecondsSinceEpoch}';
//     Map data = {
//       // Removing the kobo by multiplying with 100
//       "amount": double.parse('${_amount * 100}').toInt(),
//       "email": email,
//       "reference": _ref,
//       "callback_url": "https://github.com/ujahmycine",
//       "metadata": {"cancel_action": "https://www.google.com/"}
//     };
//
//     String authUrl = await makeAPICall(data);
//
//     if (authUrl.isNotEmpty) {
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (_) => WebViewExample(
//             healthPlan: ,
//                 authUrl: authUrl,
//                 ref: _ref,
//               )));
//     }
//   }
//
//   makeAPICall(data) async {
//     return PaymentAPIService().authorizeUrl(data);
//   }
// }
