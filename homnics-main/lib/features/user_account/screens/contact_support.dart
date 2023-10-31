import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
   late final WebViewController controller;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
    ..loadRequest(Uri.parse('https://ahegel.com/clients.html'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Support'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}