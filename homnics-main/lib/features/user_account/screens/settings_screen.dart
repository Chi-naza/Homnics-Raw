import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/user_account/screens/contact_support.dart';
import 'package:homnics/features/user_account/screens/feedback_screen.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'faq_screen.dart';

enum ThemeModeOption { light, dark }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitch = false;
  bool isSwitchEmail = true;
  bool isSwitchNotification = true;
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
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              // color: iconsColor,
            ),
          ),
          title: Text(
            "Settings",
            style: TextStyle(
              // color: textColor,
              fontSize: 20,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "APP",
                  style: TextStyle(
                    //color: textColor,
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // const snackBar = SnackBar(
                  //   content: Text('Coming soon! Keep an eye out!'),
                  // );
                  //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: appBarColor,
                      ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: greyColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Theme",
                              style: TextStyle(
                                color: greyColor,
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                // Logical error that should be fixed
                                // final isDarkMode = ref.watch(isDarkModeProvider);
                                return CupertinoSwitch(
                                  value: isSwitch,
                                  activeColor: primaryColor,
                                  onChanged: (bool value) {
                                    setState(() {
                                      print(value);
                                      isSwitch = value;
                                      if (value) {
                                        ref
                                            .read(themeModeProvider.notifier)
                                            .state = ThemeMode.dark;
                                      } else {
                                        ref
                                            .read(themeModeProvider.notifier)
                                            .state = ThemeMode.light;
                                      }
                                    });
                                  },
                                );
                              },
                            ),

                            Text(
                              isSwitch ? "Dark" : "Light",
                              style: TextStyle(
                                color: greyColor,
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            // Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: greyColor,
                            //   size: 16,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "NOTIFICATION",
                  style: TextStyle(
                    //color: textColor,
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: appBarColor,
                    ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: greyColor,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                              color: greyColor,
                              fontSize: 16,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    CupertinoSwitch(
                      thumbColor: greyColor,
                      activeColor: primaryColor,
                      trackColor: Colors.white,
                      value: isSwitchEmail,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitchEmail = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: appBarColor,
                    ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_android_outlined,
                            color: greyColor,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "In-app",
                            style: TextStyle(
                              color: greyColor,
                              fontSize: 16,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    CupertinoSwitch(
                      thumbColor: greyColor,
                      activeColor: primaryColor,
                      trackColor: Colors.white,
                      value: isSwitchNotification,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitchNotification = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "HELP & FEEDBACK",
                  style: TextStyle(
                    // color: textColor,
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // const snackBar = SnackBar(
                  //   content: Text('Coming soon! Keep an eye out!'),
                  // );
                  //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FAQScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: appBarColor,
                      ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.question_mark_rounded,
                              color: greyColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "FAQs",
                              style: TextStyle(
                                color: greyColor,
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: greyColor,
                        size: 16,
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FeedbackScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: appBarColor,
                      ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.feedback_outlined,
                              color: greyColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Feedback",
                              style: TextStyle(
                                color: greyColor,
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: greyColor,
                        size: 16,
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "SUPPORT",
                  style: TextStyle(
                    //color: textColor,
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ContactSupportScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: appBarColor,
                      ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.support_agent,
                              color: greyColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Contact support",
                              style: TextStyle(
                                color: greyColor,
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: greyColor,
                        size: 16,
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeModeProvider.notifier);
  return themeMode == ThemeMode.dark;
});
