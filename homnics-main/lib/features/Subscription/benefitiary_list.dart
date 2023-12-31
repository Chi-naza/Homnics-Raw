import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/Subscription/new_beneficiary.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentication/controller/authentication_controller.dart';
import '../../common/utils/colors.dart';
import '../../services/base_api.dart';
import '../../services/constants.dart';
import '../user_account/screens/subscription_screen.dart';

class BenefitiaryListScreen extends StatefulWidget {
  const BenefitiaryListScreen({super.key});

  @override
  State<BenefitiaryListScreen> createState() => _BenefitiaryListScreenState();
}

class _BenefitiaryListScreenState extends State<BenefitiaryListScreen> {
  List planBeneficiaries = [];
  bool isLoading = true;
  var authenticationController = Get.find<AuthenticationController>();

  @override
  void initState() {
    super.initState();
    fetchBenefitiary();
  }

  var userPlanController = Get.find<UsersPlanController>();

  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Get.offAll(SubscriptionScreen());
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: iconsColor,
              ),
            ),
          ),
          title: Text(
            "BeneficiaryList",
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              navigateToAddPage();
            },
            label: Text("add beneficiary")),
      );
    } else {
      if (planBeneficiaries.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appBarColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: iconsColor,
              ),
            ),
            title: Text(
              "BeneficiaryList",
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Center(
            child: Text(
              "No beneficiary added",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                navigateToAddPage();
              },
              label: Text("add beneficiary")),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appBarColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: iconsColor,
              ),
            ),
            title: Text(
              "BeneficiaryList",
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: fetchBenefitiary,
            child: ListView.builder(
              itemCount: planBeneficiaries.length,
              itemBuilder: (context, index) {
                final planBeneficiary = planBeneficiaries[index] as Map;
                final planBeneficiaryId = planBeneficiary['id'] as String;

                return ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('${index + 1}'),
                  ),
                  title: Text(
                      "${planBeneficiary['firstName']} ${planBeneficiary['lastName']}"),
                  subtitle: Text(
                    "added on ${planBeneficiary['createdDate']}",
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: Container(
                    width: 55,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            authenticationController
                                .aPiSnackBar("Unable to update user");
                            //navigateToEditAddPage(planBeneficiary);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(
                              Icons.list_rounded,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final beneficiaryId =
                                planBeneficiary['id'] as String;
                            print("Beneficiary ID to delete: $beneficiaryId");
                            deleteByUserId(beneficiaryId);
                          },
                          child: Icon(
                            Icons.delete,
                            color: emergencyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                navigateToAddPage();
              },
              label: Text("add beneficiary")),
        );
      }
    }
  }

  Future<void> navigateToAddPage() async {
    final route =
        MaterialPageRoute(builder: (context) => NewBeneficiaryScreen());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchBenefitiary();
  }

  void navigateToEditAddPage(Map planBeneficiary) {
    final route = MaterialPageRoute(
        builder: (context) => NewBeneficiaryScreen(
              addedBenefitiary: planBeneficiary,
              userPlanId: planBeneficiary['id'] as String,
            ));
    Navigator.push(context, route);
  }

  Future<void> deleteByUserId(String beneficiaryId) async {
    final url = baseUrl + deleteUserPlanBeneficiaryByIdUrl(beneficiaryId);

    final response = await delete(Uri.parse(url),
        headers: await authenticationController.userHeader());
    print(response.statusCode);

    if (response.statusCode < 400) {
      const snackBar = SnackBar(
        content: Text('Beneficiary Deleted!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("Data Successfully deleted");
      final filtered = planBeneficiaries
          .where((element) => element['id'] != beneficiaryId)
          .toList();
      //final filtered = planBeneficiaries.where((element) => element['id'] != UserPlanController().getActivePlanId()).toList();
      setState(() {
        planBeneficiaries = filtered;
      });
    } else {
      const snackBar = SnackBar(
        content: Text('Failed to Delete Beneficiary!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      throw Exception('Failed to delete data!');
    }
  }

  Future<void> fetchBenefitiary() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var planId = await _pref.getString("health_plan_id") ?? '';
    print(planId);
    var url = baseUrl + userPlanBeneficiaryUrl(planId);
    final response = await get(Uri.parse(url),
        headers: await authenticationController.userHeader());

    if (response.statusCode == 200) {
      var resultJson = json.decode(response.body) as Map;
      print(response.statusCode);

      final result = resultJson['planBeneficiaries'] as List;

      setState(() {
        planBeneficiaries = result;
      });

      print(resultJson['planBeneficiaries'][0]["id"]);

      // return resultJson['planBeneficiaries'][0]['id'];
    } else {
      // isLoading = false;
      throw Exception('Failed to load data!');
    }
    setState(() {
      isLoading = false;
    });
  }
}
