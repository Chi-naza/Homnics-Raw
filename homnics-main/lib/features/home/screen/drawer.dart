import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/authentication/controller/authentication_controller.dart';
import 'package:homnics/features/onboarding/screens/onboarding_screens.dart';
import 'package:homnics/features/user_account/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/HealthPlans/views/healthplansScreen.dart';
import 'package:homnics/features/user_account/profile_screen.dart';

import '../../auth/controllers/auth_api.dart';
import '../../auth/models/user.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  var authenticationController = Get.find<AuthenticationController>();

  Future<void> _clearTokenAndNavigateToLogin(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_token');
    prefs.clear();

    // Delay the navigation slightly to give the indicator some time to show
    await Future.delayed(Duration(seconds: 1));

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SlidersScreen())); // Replace '/login' with your login route
  }

  String networkImage =
      'https://homnics-dump.s3.amazonaws.com/homnics-avatar/no_face.jpg';
  String? useremail;
  // User? userData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = authenticationController.userInfo;

    return Container(
      color: Theme.of(context).drawerTheme.backgroundColor,
      // color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: user.value.avatar,
                  placeholder: (context, image) => CircularProgressIndicator(),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 50,
                  ),
                  errorWidget: (context, image, error) => CircleAvatar(
                    child: Image.network(
                        'https://homnics-dump.s3.amazonaws.com/homnics-avatar/no_face.jpg'),
                    radius: 50,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  "${user.value.fullName}",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: primaryColor,
              //color: primaryColor,
            ),
          ),
          Wrap(
            runSpacing: 16,
            children: [
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: greyColor,
                ),
                title: Text('Upgrade Plan'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => NewUserHealthcare()));
                  // Handle Home item tap
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: greyColor,
                ),
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ProfileScreen()));
                  // Handle Profile item tap
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: greyColor,
                ),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SettingsScreen()));
                  // Handle Settings item tap
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: greyColor,
                ),
                title: GestureDetector(
                    onTap: () {
                      _clearTokenAndNavigateToLogin(context);
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    )),
                onTap: () {
                  //
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
