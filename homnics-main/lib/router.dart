import 'package:flutter/material.dart';
import 'package:homnics/features/HealthPlans/views/healthplansScreen.dart';
import 'package:homnics/features/auth/screens/reset_password_screen.dart';
import 'package:homnics/features/auth/screens/signin_screen.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';

import 'common/widgets/widgets.dart';
import 'features/auth/screens/auth_screens.dart';
import 'features/auth/screens/reset_success_screen.dart';
import 'features/notifications/screens/notification_screen.dart';
import 'features/onboarding/screens/onboarding_screens.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SlidersScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SlidersScreen(),
      );
    case AccountSuccessScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AccountSuccessScreen(),
      );
    case OTPErrorScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const OTPErrorScreen(),
      );
    case OTPScreen.routeName:

      //final String userId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(),
      );
    case SignInScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );
    case ResetPasswordScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      );
    case ResetSuccessScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ResetSuccessScreen(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );
    case NewUserHealthcare.routeName:
      return MaterialPageRoute(
        builder: (context) => const NewUserHealthcare(),
      );
    // case PlanCheckOutScreen.routeName:
    //   final arguments = settings.arguments as Map;
    //   final isIndividual = arguments['isIndividual'] as bool;
    //   final plan = arguments['plan'] as String;
    //
    //   return MaterialPageRoute(
    //     builder: (context) => PlanCheckOutScreen(
    //       isIndividual: isIndividual,
    //       plan: plan, healthPlan: null,
    //     ),
    //   );
    case NavigationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const NavigationScreen(),
      );
    case NotificationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
