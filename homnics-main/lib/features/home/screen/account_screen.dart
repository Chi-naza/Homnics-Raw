import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/appointment/screens/locate_pharmacy_screen.dart';
import 'package:homnics/features/user_account/profile_screen.dart';
import 'package:homnics/features/user_account/screens/settings_screen.dart';
import 'package:homnics/features/user_account/screens/subscription_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../authentication/controller/authentication_controller.dart';
import '../../HealthPlans/controllers/UserPlanController.dart';
import '../../HealthPlans/models/health_plan_model.dart';
import '../../auth/controllers/auth_api.dart';

class AccountScreen extends StatefulWidget {
  HealthPlan? healthPlan;

  AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var auth = Get.find<AuthAPI>();
  var authenticationController = Get.find<AuthenticationController>();
  var userPlanController = Get.find<UsersPlanController>();
  // String? currentPlan;
  // User user = User(
  //   id: '',
  //   email: '',
  //   phone: '',
  //   password: '',
  //   firstName: '',
  //   lastName: '',
  //   address: '',
  //   emergencyContactName: '',
  //   emergencyContactPhone: '',
  //   city: '',
  //   state: '',
  //   country: '',
  //   postalCode: '',
  //   gender: '',
  //   emergencyContactRelationship: '',
  //   dateOfBirth: '',
  // );

  // String? firstName;
  // String? startDate;
  String? networkImage;
  final currentPlan = "".obs;

  @override
  void initState() {
    // getuser();
    super.initState();
    authenticationController.getCurrentLoggedInUser();
    // userDetails();
    //getHealthPlans();
  }

  Future<void> getuserPlan() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    currentPlan.value = (await _pref.getString("health_plan_name"))!;

    print("CURRENT PLAN : $currentPlan");
  }

  @override
  Widget build(BuildContext context) {
    var user = authenticationController.userInfo;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          //backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          centerTitle: true,

          title: Text(
            "Account",
            style: TextStyle(
              // color: textColor,
              fontSize: 20,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        //backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: appBarColor,
                      // image: DecorationImage(
                      //     image: NetworkImage(
                      //            "${networkImage}"),
                      //     fit: BoxFit.cover)
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 160,

                      alignment: Alignment.bottomCenter,

                      // linearGradient: LinearGradient(
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //     colors: [
                      //       appBarColorForGlass.withOpacity(0.1),
                      //       appBarColorForGlass.withOpacity(0.1)
                      //       // Color(0xFFF5FFFF).withOpacity(0.1),
                      //       // Color(0xFFF5FFFF).withOpacity(0.05),
                      //     ],
                      //     stops: [
                      //       0.1,
                      //       1,
                      //     ]),
                      // borderGradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [
                      //     Color(0xFFffffff).withOpacity(0.5),
                      //     Color((0xFFFFFFFF)).withOpacity(0.5),
                      //   ],
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // SizedBox(
                            //   width: 10,
                            // ),
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                  imageUrl: networkImage ??
                                      'https://homnics-dump.s3.amazonaws.com/homnics-avatar/no_face.jpg',
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30,
                                  ),
                                  imageBuilder: (context, image) =>
                                      CircleAvatar(
                                    backgroundImage: image,
                                    radius: 30,
                                  ),
                                  errorWidget: (context, image, error) =>
                                      CircleAvatar(
                                    child: Image.network(
                                        'https://homnics-dump.s3.amazonaws.com/homnics-avatar/no_face.jpg'),
                                    radius: 50,
                                  ),
                                )
                                //  CircleAvatar(
                                //   radius: 30.0,
                                //   backgroundImage: NetworkImage(
                                //      "${networkImage}"),
                                //   backgroundColor: Colors.transparent,
                                // ),
                                ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          user.value
                                              .firstName, //'${firstName ?? ''}',
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontFamily: 'RedHatDisplay',
                                              fontWeight: FontWeight.w500,
                                              color: iconsColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  SizedBox(
                                    child: Text(
                                      "${currentPlan}", //"${currentPlan ?? "Freemium"}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w400,
                                          color: iconsColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      child: Text(
                                        _formatDate(userPlanController
                                            .planStartDate
                                            .value), //_formatDate("${startDate ?? ''}"),
                                        //DateFormat('EEE, d MMM y').format(DateTime.parse("${startDate ?? "Started Date"}")),
                                        // '${startDate ?? "Started Date"}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'RedHatDisplay',
                                            fontWeight: FontWeight.w400,
                                            color: iconsColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.person,
                    color: secondaryFillColor,
                  ),
                  title: Text(
                    'Profile',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      //color: secondaryFillColor
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: secondaryFillColor,
                    size: 20,
                  ),
                ),
              ),

              Divider(color: greyColor),

              Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => SubscriptionScreen()),
                    );
                  },
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.payments_outlined,
                    color: secondaryFillColor,
                  ),
                  title: Text(
                    'Subscription',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      //color: secondaryFillColor
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: secondaryFillColor,
                    size: 20,
                  ),
                ),
              ),
              Divider(color: greyColor),

              Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => LocatePharmacyScreen()),
                    );
                  },
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.inbox_rounded,
                    color: secondaryFillColor,
                  ),
                  title: Text(
                    'Messages',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      // color: secondaryFillColor
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: secondaryFillColor,
                    size: 20,
                  ),
                ),
              ),
              Divider(color: greyColor),

              Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.settings,
                    color: secondaryFillColor,
                  ),
                  title: Text(
                    'Settings',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      // color: secondaryFillColor
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: secondaryFillColor,
                    size: 20,
                  ),
                ),
              ),
              Divider(color: greyColor),

              Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => LocatePharmacyScreen()),
                    );
                  },
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Icon(
                    Icons.shield,
                    color: secondaryFillColor,
                  ),
                  title: Text(
                    'Security and Privacy',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      //color: secondaryFillColor
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: secondaryFillColor,
                    size: 20,
                  ),
                ),
              ),
              Divider(color: greyColor),
              // GestureDetector(
              //   onTap: () {
              //      Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => LocatePharmacyScreen()));
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(16),
              //     child: Row(
              //       children: [
              //         Icon(
              //           Icons.card_giftcard,
              //           color: emergencyColor,
              //         ),
              //         SizedBox(
              //           width: 20,
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               'Invite friends, get...',
              //               textAlign: TextAlign.left,
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   fontFamily: 'RedHatDisplay',
              //                   fontWeight: FontWeight.w500,
              //                   color: emergencyColor),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //           ],
              //         ),
              //         Spacer(),
              //         // Icon(
              //         //   Icons.arrow_forward_ios,
              //         //   color: secondaryFillColor,
              //         //   size: 20,
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => LocatePharmacyScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    visualDensity: VisualDensity(vertical: -4),
                    leading: Icon(
                      Icons.card_giftcard,
                      color: emergencyColor,
                    ),
                    title: Text(
                      'Invite friends, get...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w500,
                          color: emergencyColor),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: secondaryFillColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Divider(color: greyColor),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  // Future<void> getuser() async {
  //   user = AuthAPI().userInfo;
  //   setState(() {});
  // }

  String _formatDate(String rawDate) {
    try {
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(rawDate);
      return DateFormat('EEE, d MMM y').format(parsedDate);
    } catch (e) {
      return 'Started Date:'; // Handle invalid date format
    }
  }

  // Future<List<HealthPlan>> getHealthPlans() async {
  //   List<HealthPlan> _healthplans = await HealthPlanApi().gethealthplans();
  //   _healthplans.forEach((element) {
  //     print(element.id);
  //     print(element.name);
  //   });
  //   return _healthplans;
  // }
}
