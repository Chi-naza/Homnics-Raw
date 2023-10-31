import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/authentication/controller/authentication_controller.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/appointment/screens/locate_pharmacy_screen.dart';
import 'package:homnics/features/appointment/widgets/appointment_list_filter.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/utils/scale_size.dart';
import '../../../common/widgets/health_tips_widget.dart';
import '../../HealthPlans/controllers/healthplan_api.dart';
import '../../HealthPlans/models/health_plan_model.dart';
import '../../appointment/screens/booking_calender.dart';

import '../../notifications/screens/all_notifications.dart';
import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  HealthPlan healthPlan;

  HomeScreen({required this.healthPlan, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var auth = Get.find<AuthAPI>();
  var authenticationController = Get.find<AuthenticationController>();
  var userPlanController = Get.put(UsersPlanController());
  // var userPlanController = Get.find<UsersPlanController>();

  var orientation, size, height, width;

  // late User user;

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AppointmentListFilterState> appointmentListFilterKey =
      GlobalKey<AppointmentListFilterState>();
  // String? fName;
  final currentPlan = "".obs;
  // User? userData;

  @override
  void initState() {
    authenticationController.getCurrentLoggedInUser();
    super.initState();
    getuserPlan();
  }

  HealthPlanApi healthPlanApi = HealthPlanApi();
  @override
  Widget build(BuildContext context) {
    var user = authenticationController.userInfo;
    print('USER- ${user.value.firstName}');

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: CircleAvatar(
            backgroundColor: appBarColor,
            child: Image.asset(
              'assets/images/landing/img.png',
            ),
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Obx(() {
            return Text(
              "Homnnnics - ${currentPlan ?? userPlanController.userPlanName.value}",
              style: TextStyle(
                //color: textColor,
                fontSize: 16,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w500,
              ),
            );
          }),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: false).push(
                  MaterialPageRoute(
                      builder: (context) => DisplayNotificationsScreen(),
                      maintainState: false));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.notifications_outlined,
                size: 26,
                // color: iconsColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.grid_view_rounded,
                size: 26,
                //Scolor: iconsColor,
              ),
            ),
          ),
        ],
      ),
      endDrawer: NavDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    userPlanController.getCurrentUserPlan();
                    // authenticationController.getCurrentLoggedInUser();
                  },
                  child: Text(
                    'Welcome ${user.value.firstName.toUpperCase()}', //?? user.email
                    textAlign: TextAlign.left,
                    textScaleFactor: ScaleSize.textScaleFactor(context),
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w500,
                        color: primaryColor),
                  ),
                ),
                Text(
                  'What would you like to do today?',
                  textAlign: TextAlign.left,
                  textScaleFactor: ScaleSize.textScaleFactor(context),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                    //color: iconsColor
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (3 > 5) {
                      //userPlanController.userPlanName.isEmpty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Kindly upgrade plan before booking appointment!"),
                          duration: Duration(
                              seconds:
                                  2), // Duration for which the toast should be visible
                        ),
                      );
                      //  showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return FreemiumDisplayDialog(
                      //         title: 'Upgrade Plan',
                      //       );
                      //     });
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingsCalender()));
                    }

                    // removing ProfessionalScreen
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          //color: iconsColor,
                          size: 24,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Book Appointment',
                              textAlign: TextAlign.left,
                              textScaleFactor:
                                  ScaleSize.textScaleFactor(context),
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w500,
                                //color: iconsColor
                              ),
                            ),
                            Text(
                              'Find a doctor',
                              textAlign: TextAlign.left,
                              textScaleFactor:
                                  ScaleSize.textScaleFactor(context),
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                                // color: iconsColor
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocatePharmacyScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_pharmacy_outlined,
                          //color: iconsColor,
                          size: 24,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Locate a Pharmacy',
                              textAlign: TextAlign.left,
                              textScaleFactor:
                                  ScaleSize.textScaleFactor(context),
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w500,
                                //color: iconsColor
                              ),
                            ),
                            Text(
                              'Purchase medicines',
                              textAlign: TextAlign.left,
                              textScaleFactor:
                                  ScaleSize.textScaleFactor(context),
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                                // color: iconsColor
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'More actions >',
                  textAlign: TextAlign.left,
                  textScaleFactor: ScaleSize.textScaleFactor(context),
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w400,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 16,
                ),
                ResponsiveWrapper(
                  breakpoints: const [
                    ResponsiveBreakpoint.resize(350, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(600, name: TABLET),
                    ResponsiveBreakpoint.resize(800, name: DESKTOP),
                    ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
                  ],
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            const snackBar = SnackBar(
                              content: Text('please wait..'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            emergencyCall();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Card(
                              shadowColor: iconsColor,
                              elevation: 5,
                              color: emergencyColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //     color: emergencyColor,
                                //     borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.emergency_outlined,
                                      size: 40,
                                      color: Colors.white24,
                                    ),
                                    SizedBox(
                                      height: 28,
                                    ),
                                    Text(
                                      'EMERGENCY',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w700,
                                          color: appStatusColor),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Need help right away!',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 9.0,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w500,
                                          color: appStatusColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            // const snackBar = SnackBar(
                            //   content: Text('please wait...'),
                            // );
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return HealthTipsWidget(
                                    title: 'Daily Tip',
                                  );
                                });
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             RecommendationsScreen()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5, //4
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Card(
                              shadowColor: iconsColor,
                              elevation: 5,
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //     color: emergencyColor,
                                //     borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.tips_and_updates_outlined,
                                      size: 40,
                                      color: Colors.white24,
                                    ),
                                    SizedBox(
                                      height: 28,
                                    ),
                                    Text(
                                      'HEALTH TIPS',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w700,
                                          color: appStatusColor),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Up-to-date info',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 9.0,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w500,
                                          color: appStatusColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      'Upcoming Appointments',
                      textAlign: TextAlign.left,
                      textScaleFactor: ScaleSize.textScaleFactor(context),
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             FiltteredAppointmentsHome()));
                        },
                        child: Text(
                          'See All >',
                          textAlign: TextAlign.left,
                          textScaleFactor: ScaleSize.textScaleFactor(context),
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                              color: primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Center(
                    child: Container(
                        //constraints: BoxConstraints(maxHeight: 500, minHeight: 200),
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    child: Image.network(
                                        'https://img.freepik.com/premium-vector/important-information-from-doctor-2d-vector-isolated-illustration_151150-10360.jpg?w=740'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    "No Appointments Here",
                                    style: TextStyle(
                                      color: greyColor,
                                      fontSize: 16,
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //   AppointmentListFilter(
                          //     key: appointmentListFilterKey,
                          //     status: 2,
                          //   ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> getuserPlan() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    currentPlan.value = (await _pref.getString("health_plan_name"))!;
    print("CURRENT PLAN : $currentPlan");
  }

  emergencyCall() async {
    var url = Uri.parse("tel:08032744652");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
