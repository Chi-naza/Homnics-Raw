import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:homnics/authentication/controller/authentication_controller.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/auth/controllers/auth_api.dart';
import 'package:homnics/features/onboarding/screens/onboarding_screens.dart';
import 'package:homnics/router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/screen/navigation_screen.dart';
import 'features/user_account/screens/settings_screen.dart';

//final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: appBarColor,
            titleTextStyle: TextStyle(color: textColor),
            iconTheme: IconThemeData(color: iconsColor),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: appStatusColor,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark)),
        // Define the default brightness and colors.
        cardColor: lightColor,
        focusColor: primaryColor,
        drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
        iconTheme: IconThemeData(color: iconsColor),

        // Define the default font family.
        fontFamily: 'RedHatDisplay',
        primaryColor: primaryColor,

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 36.0,
            fontStyle: FontStyle.italic,
          ),
          headlineMedium:
              TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(
              primary: primaryColor,
            )
            .copyWith(background: lightBackgroundColor),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: darkbackgroundColor,
          //backgroundColor: darkbackgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: darkappbaebackgroundColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
        focusColor: primaryColor,
        drawerTheme: DrawerThemeData(backgroundColor: darkbackgroundColor),
        primaryColor: Colors.white,
        cardColor: secondaryFillColor,
        //fontFamily: 'RedHatDisplay',
        //bottomAppBarColor: primaryColor,
        //  bottomAppBarTheme: BottomAppBarTheme(color: Colors.amber),
        //  iconTheme: IconThemeData(color: appBarColor),
        //  navigationRailTheme: NavigationRailThemeData(backgroundColor: Colors.amber),
        //  navigationBarTheme: NavigationBarThemeData(backgroundColor: Colors.amber),
        //  //drawerTheme: DrawerThemeData(backgroundColor: Colors.amber),
        //  navigationDrawerTheme: NavigationDrawerThemeData(backgroundColor: Colors.amber),

        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          headlineMedium:
              TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(
              primary: primaryColor,
            )
            .copyWith(background: darkbackgroundColor),
      ),
      themeMode: themeMode,
      builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),

          // breakpointsLandscape: const[
          //     ResponsiveBreakpoint.resize(360, name: MOBILE, scaleFactor: 0.6),
          //     ResponsiveBreakpoint.resize(520, name: MOBILE, scaleFactor: 0.6),
          //     ResponsiveBreakpoint.resize(600, name: TABLET, scaleFactor: 0.8),
          //     ResponsiveBreakpoint.autoScale(800, name: TABLET, scaleFactor: 0.8),
          //     ResponsiveBreakpoint.resize(1000, name: DESKTOP, scaleFactor: 1.1),
          //     ResponsiveBreakpoint.autoScale(1200, name: DESKTOP, scaleFactor: 1.1),
          //     ResponsiveBreakpoint.autoScale(2460, name: '4K', scaleFactor: 1.7),
          // ],
          breakpoints: const [
            ResponsiveBreakpoint.resize(360, name: MOBILE),
            ResponsiveBreakpoint.autoScale(600, name: TABLET),
            ResponsiveBreakpoint.resize(800, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
          ]),
      home: SplashScreen(),
      title: 'Homnics',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  Future<void> checkUserStatus() async {
    Get.put(AuthenticationController(), permanent: true);
    Get.put(AuthAPI(), permanent: true);
    Get.put(UsersPlanController(), permanent: true);
    // final SharedPreferences _pref = await SharedPreferences.getInstance();
    // final String? email = _pref.getString('user_email');

    // String initialRoute =
    //     email != null ? NavigationScreen.routeName : SlidersScreen.routeName;

    // if (email != null) {
    //   await auth.getCurrentUser();
    //   await up.getCurrentUserPlan();
    //   initialRoute = NavigationScreen.routeName;
    // } else {
    //   initialRoute = SlidersScreen.routeName;
    // }

    // Remove the splash screen overlay
    FlutterNativeSplash.remove();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacementNamed(SlidersScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color
      body: Center(
        child: Image.asset(
          'assets/images/landing/logo.png',
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width / 3,
        ), //CircularProgressIndicator(), // image will still show here as the loading indicator
      ),
    );
  }
}
