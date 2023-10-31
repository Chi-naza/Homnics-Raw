import 'package:flutter/material.dart';
import 'package:homnics/common/utils/colors.dart';

class SecurityAndPrivacyScreen extends StatefulWidget {
  const SecurityAndPrivacyScreen({super.key});

  @override
  State<SecurityAndPrivacyScreen> createState() =>
      _SecurityAndPrivacyScreenState();
}

class _SecurityAndPrivacyScreenState extends State<SecurityAndPrivacyScreen> {
  bool isSwitch = true;
  @override
  Widget build(BuildContext context) {
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
            "Security & Privacy",
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "PASSWORD",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appBarColor,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.key,
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "2FA AUTHENTIFICATION",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appBarColor,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.dialpad,
                            color: greyColor,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Phone number",
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appBarColor,
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appBarColor,
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
                            "Authenticator app",
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "PRIVACY",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: appBarColor,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: greyColor,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Privacy policy",
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
            ],
          ),
        ));
  }
}
