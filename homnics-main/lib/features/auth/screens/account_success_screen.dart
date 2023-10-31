import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/auth/controllers/auth_api.dart';

import '../../HealthPlans/controllers/UserPlanController.dart';
import '../../HealthPlans/controllers/healthplan_api.dart';
import '../../HealthPlans/models/health_plan_model.dart';
import '../../HealthPlans/models/user-plan.dart';
import '../../home/screen/navigation_screen.dart';
import '../models/user.dart';

class AccountSuccessScreen extends StatefulWidget {
  static const routeName = '/account-success-screen';
  const AccountSuccessScreen({super.key});

  @override
  State<AccountSuccessScreen> createState() => _AccountSuccessScreenState();
}

class _AccountSuccessScreenState extends State<AccountSuccessScreen> {
  // auth controller
  var auth = Get.find<AuthAPI>();
  // user plan controller
  var userPlanController = Get.find<UsersPlanController>();

  @override
  void initState() {
    super.initState();
    _navigateNewUserHealthcare();
  }

  _navigateNewUserHealthcare() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    // Navigator.pushNamed(context, NewUserHealthcare.routeName);
    List<HealthPlan> _healthplans = await HealthPlanApi().gethealthplans();
    HealthPlan healthPlan =
        _healthplans.where((element) => element.id == 6).first;
    User user = auth.userInfo.value;
    print(user.id);
    UserPlan userPlan = UserPlan(
        userId: user.id,
        healthPlanId: healthPlan.id!,
        planDurationId: 1,
        startDate: DateTime.now().toString(),
        startImmediately: true);
    await userPlanController.storeUserPlan(userPlan);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => NavigationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: appStatusColor,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/landing/img.png',
                height: 24,
                width: 27,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Homnics",
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/landing/checkcircle.png'),
            SizedBox(
              width: 250,
              child: Text(
                'Your account has been created successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
