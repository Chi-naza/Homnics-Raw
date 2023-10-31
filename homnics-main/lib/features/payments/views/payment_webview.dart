import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';

import 'package:homnics/features/home/screen/navigation_screen.dart';
import 'package:homnics/features/payments/controllers/payment_API_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../../authentication/controller/authentication_controller.dart';
import '../../HealthPlans/models/health_plan_model.dart';
import '../../HealthPlans/models/user-plan.dart';
import '../../auth/models/user.dart';

class WebViewExample extends StatefulWidget {
  HealthPlan healthPlan;
  String authUrl;
  String ref;
  String? title;
  String email;
  WebViewExample(
      {required this.healthPlan,
      required this.authUrl,
      required this.ref,
      this.title = 'Payment Page',
      required this.email,
      super.key});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;
  var authenticationController = Get.find<AuthenticationController>();

  //var userPlanController = Get.find<UsersPlanController>();

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            if (request.url == 'https://standard.paystack.co/close') {
              Navigator.of(context).pop(); //close webview
            }

            if (request.url == "https://hello.pstk.xyz/callback") {
              Navigator.of(context).pop(); //close webview
            }
            //closes the webview on callback to github repo
            if (request.url.contains('github')) {
              verifyTransaction(widget.ref);
              // Navigator.of(context).pop(); //close webview
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.authUrl));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        // leading: SvgPicture.asset('assets/images/landing/healthsafety.svg'),
        title: Text(widget.title ?? "Payment Page"),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: WebViewWidget(controller: _controller),
      //floatingActionButton: favoriteButton(),
    );
  }

  // Widget favoriteButton() {
  //   return FloatingActionButton(
  //     onPressed: () async {
  //       final String? url = await _controller.currentUrl();
  //       if (context.mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Favorited $url')),
  //         );
  //       }
  //     },
  //     child: const Icon(Icons.favorite),
  //   );
  // }

  Future<void> verifyTransaction(String ref) async {
    bool isSuccess = await PaymentAPIService().verifyTransaction(ref);
    if (isSuccess) {
      await createUserPlan();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => NavigationScreen()));
    } else {
      Navigator.pop(context);
    }
  }

  createUserPlan() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setInt("user_healthplan_id", widget.healthPlan.id!);
    await _pref.setString("health_plan_name", widget.healthPlan.name!);

    //User user = await User.getCurrentLoggedInUser();
    var (userId, email, password, token) =
        await authenticationController.fetchUserData();
    UserPlan(
        userId: userId,
        healthPlanId: widget.healthPlan.id!,
        planDurationId: 1,
        startDate: DateTime.now().toString(),
        startImmediately: true);

    // userPlanController.storeUserPlan(uPlan);

    return;
  }
}
