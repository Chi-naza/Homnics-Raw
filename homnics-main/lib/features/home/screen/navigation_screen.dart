import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/home/screen/account_screen.dart';
import 'package:homnics/features/home/screen/activity_screen.dart';
import 'package:homnics/features/home/screen/home_screen.dart';
import 'package:homnics/features/professionals/views/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../authentication/controller/authentication_controller.dart';
import '../../HealthPlans/models/health_plan_model.dart';
import '../../auth/controllers/auth_api.dart';
import '../../auth/models/user.dart';

class NavigationScreen extends StatefulWidget {
  static const routeName = '/nav-screen';
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int index = 0;
  HealthPlan healthPlan = HealthPlan();
  List<Widget> screens = [];
  String? networkImage =
      'https://ahegel-dump.s3.amazonaws.com/homnics-avatar/default_user.png';
  User? userData;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => SystemChannels.platform.invokeMethod(
                    'SystemNavigator.pop'), //Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    getuser();
    super.initState();
    authenticationController.getCurrentLoggedInUser();
    screens = [
      HomeScreen(
        healthPlan: healthPlan,
      ),
      ProfessionalScreen(),
      const ActivityScreen(),
      AccountScreen(),
    ];
  }

  Future<void> getuser() async {
    User userDetailDisplay = await AuthAPI().getCurrentUser();
    setState(() {
      userData = userDetailDisplay;
    });
    SharedPreferences _pref = await SharedPreferences.getInstance();
    networkImage = _pref.getString("avatar") ?? networkImage;
  }

  var authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(
    BuildContext context,
  ) {
    var user = authenticationController.userInfo;

    final items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        //backgroundColor: appBarColor,
        icon: index == 0
            ? SvgPicture.asset(
                'assets/images/landing/ahm.svg',
              )
            : SvgPicture.asset(
                'assets/images/landing/hm.svg',
              ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        //backgroundColor: appBarColor,
        icon: index == 1
            ? SvgPicture.asset(
                'assets/images/landing/ash.svg',
              )
            : SvgPicture.asset(
                'assets/images/landing/sh.svg',
              ),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // backgroundColor: appBarColor,
        icon: index == 2
            ? SvgPicture.asset(
                'assets/images/landing/aay.svg',
              )
            : SvgPicture.asset(
                'assets/images/landing/ay.svg',
              ),
        label: 'Activity',
      ),
      BottomNavigationBarItem(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        //backgroundColor: appBarColor,
        icon: CachedNetworkImage(
          imageUrl: user.value.avatar ?? networkImage!,
          placeholder: (context, url) => const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 14,
          ),
          imageBuilder: (context, image) => CircleAvatar(
            backgroundImage: image,
            radius: 14,
          ),
          errorWidget: (context, image, error) => CircleAvatar(
            child: Image.network(
                'https://homnics-dump.s3.amazonaws.com/homnics-avatar/no_face.jpg'),
            radius: 14,
          ),
        ),

        //  CircleAvatar(
        //   radius: 14,
        //   backgroundImage: NetworkImage(networkImage!),
        // ),
        label: 'Account',
      ),
    ];
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(color: Color(0xFF242624)),
          selectedItemColor: primaryColor,
          unselectedItemColor: Color.fromARGB(255, 57, 61, 57),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          //backgroundColor: appBarColor,
          onTap: (index) => setState(() => this.index = index),
          currentIndex: index,
          items: items,
        ),
      ),
    );
  }
}
