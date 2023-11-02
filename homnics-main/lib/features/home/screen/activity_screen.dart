import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/prescription/controllers/prescription_controller.dart';
import 'package:homnics/services/constants.dart';
import 'package:http/http.dart';
import '../../../authentication/controller/authentication_controller.dart';
import '../../../services/base_api.dart';
import '../../HealthPlans/controllers/UserPlanController.dart';
import '../../appointment/widgets/appointment_list_filter.dart';
import '../../appointment/widgets/ecg_loader.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int tabID = 1;
  bool isSwitch = true;
  List latestAppointment = [];
  List latestPrescription = [];
  bool isLoading = false;
  late Future<dynamic> prescriptionsData;
  String dropdownValue = 'Appointments';
  String selectedOption = 'Appointments';

  GlobalKey<AppointmentListFilterState> appointmentListFilterKey =
      GlobalKey<AppointmentListFilterState>();

  void onTabChanged(int tabIndex) {
    setState(() {
      tabID = tabIndex;
    });

    // Call the refreshData method of the AppointmentListFilter widget
    appointmentListFilterKey.currentState?.refreshData(tabIndex);
  }

  var userPlanController = Get.find<UsersPlanController>();
  var authenticationController = Get.find<AuthenticationController>();
  //var prescriptionController = Get.find<PrescriptionController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prescriptionsData = PrescriptionController().fetchPrescriptions();
  }

  Widget getAppointmentsWidget() {
    return Container(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSwitch ? _buildSegment() : Container(),
            Padding(
                padding:
                    const EdgeInsets.only(left: 2.0, bottom: 16.0, right: 2),
                child: Column(
                  children: [
                    Container(
                      child: _buildAppointmentBodySwitch(),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget getPrescriptionsWidget() {
    return Container(
      color: Colors.black,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: prescriptionsData, // Use the Future variable
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Display a loading indicator
              } else if (snapshot.hasError) {
                return Text(
                    "Error: ${snapshot.error}"); // Display an error message
              } else {
                // Data is available, you can access it using snapshot.data
                if (snapshot.data != null) {
                  List<dynamic> prescriptions =
                      snapshot.data; // Assuming prescriptions is a list

                  return ListView.builder(
                    itemCount: 0,
                    itemBuilder: (context, index) {
                      var prescription = prescriptions[index];

                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: greyColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        shape: BoxShape.rectangle,
                                        color: appBarColor,
                                      ),
                                      child: Icon(
                                        Icons.calendar_month_outlined,
                                        size: 18,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'instruction',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w500,
                                        color: secondaryFillColor,
                                      ),
                                    ),
                                    Text(
                                      "Format : ${prescription['format']}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w500,
                                        color: secondaryFillColor,
                                      ),
                                    ),
                                    Text(
                                      'Dr. Ben Odukoya',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w400,
                                        color: iconsColor,
                                      ),
                                    ),
                                    Text(
                                      'dosage',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w500,
                                        color: greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(color: greyColor),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Text(
                      "Data is null"); // Handle the case where data is null
                }
              }
            },
          )
        ],
      ),
    );
  }

  Widget getCurrentWidget() {
    if (selectedOption == 'Appointments') {
      return getAppointmentsWidget();
    } else if (selectedOption == 'Prescriptions') {
      return getPrescriptionsWidget();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //fetchPrescriptions();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
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
          child: Text(
            "Homnics",
            style: TextStyle(
              // color: textColor,
              fontSize: 16,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              //color: iconsColor,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.grid_view_rounded,
                // color: iconsColor,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: selectedOption,
                items: <String>['Appointments', 'Prescriptions']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue!;
                  });
                },
              ),
              getCurrentWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegment() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Theme.of(context).colorScheme.background,
        // color: Color(0xFFF5FFFF)
      )),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                onTabChanged(1);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                decoration: segmentDecoration(1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Pending', style: segmentText(1)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
                onTap: () {
                  onTabChanged(2);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                  decoration: segmentDecoration(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Scheduled', style: segmentText(2)),
                    ],
                  ),
                )),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                onTabChanged(3);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                decoration: segmentDecoration(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Declined', style: segmentText(3)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                onTabChanged(4);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                decoration: segmentDecoration(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Completed', style: segmentText(4)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  segmentText(val) {
    return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: tabID == val ? Color(0xFF0090B7) : Color(0xFF818182));
  }

  segmentDecoration(val) {
    BorderRadiusGeometry? borderRadius2;

    if (val == 1) {
      borderRadius2 = const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4));
    } else if (val == 2) {
      borderRadius2 = const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4));
    } else if (val == 3) {
      borderRadius2 = const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4));
    } else {
      borderRadius2 = const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4));
    }
    return BoxDecoration(
      border: Border.all(
          color: tabID == val ? Color(0xFFDEE2E6) : Color(0xFFF5FFFF)),
      color: tabID == val ? Color(0xFFF5FFFF) : Color(0xFFF5FFFF),
      borderRadius: borderRadius2,
    );
  }

  _buildAppointmentBodySwitch() {
    if (tabID == 1) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(),
            child: AppointmentListFilter(
              status: tabID,
              key: appointmentListFilterKey,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );
    } else if (tabID == 2) {
      return Column(
        children: [
          Container(
              decoration: BoxDecoration(),
              child: AppointmentListFilter(
                status: tabID,
                key: appointmentListFilterKey,
              )),
          SizedBox(
            height: 20,
          ),
        ],
      );
    } else if (tabID == 3) {
      return Column(
        children: [
          Container(
              decoration: BoxDecoration(),
              child: AppointmentListFilter(
                status: tabID,
                key: appointmentListFilterKey,
              )),
          SizedBox(
            height: 20,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
              decoration: BoxDecoration(),
              child: AppointmentListFilter(
                status: tabID,
                key: appointmentListFilterKey,
              )),
          SizedBox(
            height: 20,
          ),
        ],
      );
    }
  }
}
