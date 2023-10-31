import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
   late final WebViewController controller;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
    ..loadRequest(Uri.parse('https://homnics.com/faq.html'));
  }
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}