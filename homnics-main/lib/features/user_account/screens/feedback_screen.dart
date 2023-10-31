import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
   late final WebViewController controller;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
    ..loadRequest(Uri.parse('https://ahegel.com/contact-us.html'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}