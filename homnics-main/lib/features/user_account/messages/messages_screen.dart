import 'package:flutter/material.dart';
import 'package:homnics/common/utils/colors.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: iconsColor,
            )),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Messages",
            style: TextStyle(
              color: textColor,
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
              Icons.delete_outlined,
              color: iconsColor,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/5327585/pexels-photo-5327585.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Dr. Ben Odukoya',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'RedHatDisplay',
                                  fontWeight: FontWeight.w500,
                                  color: iconsColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Help us to secure your acc..',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                              color: iconsColor),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '3:00pm',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w500,
                          color: greyColor),
                    ),
                  ],
                ),
              ),
              Divider(color: greyColor),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/5327585/pexels-photo-5327585.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Dr. Ben Odukoya',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'RedHatDisplay',
                                  fontWeight: FontWeight.w500,
                                  color: iconsColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Help us to secure your acc..',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                              color: iconsColor),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '3:00pm',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w500,
                          color: greyColor),
                    ),
                  ],
                ),
              ),
              Divider(color: greyColor),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/5327585/pexels-photo-5327585.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Dr. Ben Odukoya',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'RedHatDisplay',
                                  fontWeight: FontWeight.w500,
                                  color: iconsColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Help us to secure your acc..',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                              color: iconsColor),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '3:00pm',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w500,
                          color: greyColor),
                    ),
                  ],
                ),
              ),
              Divider(color: greyColor),
            ],
          ),
        ),
      ),
    );
  }
}
