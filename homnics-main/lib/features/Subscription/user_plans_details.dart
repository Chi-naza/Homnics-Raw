import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/user_account/screens/subscription_screen.dart';

import '../HealthPlans/models/user_plan_active.dart';

class UserPlansDetailsScreen extends StatefulWidget {
  const UserPlansDetailsScreen({super.key});

  @override
  State<UserPlansDetailsScreen> createState() => _UserPlansDetailsScreenState();
}

class _UserPlansDetailsScreenState extends State<UserPlansDetailsScreen> {
  UserplansActivePayload? userPlanActive;
  var userPlanController = Get.find<UsersPlanController>();

  Future<void> getUserPlanActive() async {
    final UserplansActivePayload? response =
        await userPlanController.getCurrentUserPlan();
    if (response != null) {
      setState(() {
        userPlanActive = response;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserPlanActive();
  }

  @override
  Widget build(BuildContext context) {
    //print(userPlanActive?.userPlans[0].endDate);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SubscriptionScreen()));
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.arrow_back_ios_new,
              //color: iconsColor,
            ),
          ),
        ),
        title: Text(
          "Beneficiaries Details",
          style: TextStyle(
            //color: textColor,
            fontSize: 20,
            fontFamily: 'RedHatDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Container(color: Colors.amber),
      ),
    );
  }
}
