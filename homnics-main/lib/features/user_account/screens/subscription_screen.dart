import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/Subscription/benefitiary_list.dart';
import 'package:homnics/features/Subscription/user_plans_details.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/screen/account_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String? currentPlan;
  String? endDate;

  Future<void> userHealthPlan() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    setState(() {
      currentPlan = _pref.getString("user_plan_name") ?? '';
      endDate = _pref.getString('user_plan_end_date') ?? '';
    });

    print(endDate);
  }

  @override
  void initState() {
    // TODO: implement initState
    userHealthPlan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          //backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NavigationScreen()));
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
            "Subscription",
            style: TextStyle(
              //color: textColor,
              fontSize: 20,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: SvgPicture.asset(
                          'assets/images/landing/healthsafety.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentPlan?.toUpperCase()}",
                            style: TextStyle(
                              //color: textColor,
                              fontSize: 16,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 9.0,
                          ),
                          Text(
                            '${endDate?.split("T")[0] ?? " "}',
                            style: TextStyle(
                              //color: textColor,
                              fontSize: 16,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "One-time",
                        style: TextStyle(
                          //color: textColor,
                          fontSize: 12,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: greyColor),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: [
                    Text(
                      "Payment method",
                      style: TextStyle(
                        //color: textColor,
                        fontSize: 16,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 100,
                      height: 40,
                      child: TextField(
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                        ), //editing controller of this TextField
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: greyColor,
                          //suffixIconConstraints: BoxConstraints(minWidth: 30),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                            color: primaryColor,
                          ),
                          hintText: 'Cards',
                          hintStyle: TextStyle(
                              color: primaryColor, height: 2.7, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/landing/card.svg'),
                      SizedBox(
                        width: 18,
                      ),
                      SvgPicture.asset('assets/images/landing/card_two.svg'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                GestureDetector(
                  onTap: () {
                    const snackBar = SnackBar(
                      content: Text('Coming soon! Keep an eye out!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text(
                    "+ Add new payment method",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Divider(color: greyColor),
                SizedBox(
                  height: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Beneficiaries Covered",
                          style: TextStyle(
                            color: secondaryFillColor,
                            fontSize: 16,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserPlansDetailsScreen()));
                          },
                          child: Text(
                            "view all",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "4 People",
                        style: TextStyle(
                          color: secondaryFillColor,
                          fontSize: 16,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BenefitiaryListScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: appBarColor,
                            shape: BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        child: Text(
                          "add beneficiary",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w400,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(color: greyColor),
                Row(
                  children: [
                    Text(
                      "Subscription history",
                      style: TextStyle(
                        // color: textColor,
                        fontSize: 16,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "view all",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Individual Plan",
                          style: TextStyle(
                            color: secondaryFillColor,
                            fontSize: 16,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "N3000",
                          style: TextStyle(
                            color: secondaryFillColor,
                            fontSize: 16,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Monthly",
                      style: TextStyle(
                        color: secondaryFillColor,
                        fontSize: 16,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Date: 16/07/2022",
                      style: TextStyle(
                        color: secondaryFillColor,
                        fontSize: 16,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(color: greyColor),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Individual Plan",
                          style: TextStyle(
                            color: secondaryFillColor,
                            fontSize: 16,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "N3000",
                          style: TextStyle(
                            color: secondaryFillColor,
                            fontSize: 16,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Monthly",
                      style: TextStyle(
                        color: secondaryFillColor,
                        fontSize: 16,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Date: 16/07/2022",
                      style: TextStyle(
                        color: secondaryFillColor,
                        fontSize: 16,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(color: greyColor),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Individual Plan",
                          style: TextStyle(
                            color: secondaryFillColor,
                            fontSize: 16,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "N3000",
                          style: TextStyle(
                            color: secondaryFillColor,
                            fontSize: 16,
                            fontFamily: 'RedHatDisplay',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Monthly",
                      style: TextStyle(
                        color: secondaryFillColor,
                        fontSize: 16,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Date: 16/07/2022",
                      style: TextStyle(
                        color: secondaryFillColor,
                        fontSize: 16,
                        fontFamily: 'RedHatDisplay',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(color: greyColor),
              ],
            ),
          ),
        ));
  }
}
