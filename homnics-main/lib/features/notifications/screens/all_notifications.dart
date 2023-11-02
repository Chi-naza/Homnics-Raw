import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/features/auth/controllers/auth_api.dart';
import 'package:homnics/features/notifications/screens/tips_screen.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../../authentication/controller/authentication_controller.dart';
import '../../../services/base_api.dart';
import '../../../services/constants.dart';
import '../../auth/models/user.dart';

class DisplayNotificationsScreen extends StatefulWidget {
  const DisplayNotificationsScreen({super.key});

  @override
  State<DisplayNotificationsScreen> createState() =>
      _DisplayNotificationsScreenState();
}

class _DisplayNotificationsScreenState
    extends State<DisplayNotificationsScreen> {
  // var authController = Get.find<AuthAPI>();
  var authController = Get.find<AuthenticationController>();

  List latestNotifications = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationsById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TipsScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.tips_and_updates),
              ))
        ],
      ),
      body: latestNotifications.isEmpty
          ? Center(
              child: latestNotifications.isNotEmpty
                  ? Text("No notifications available.")
                  : CircularProgressIndicator(), // Display text if no notifications
            )
          : ListView.builder(
              itemCount: latestNotifications.length,
              itemBuilder: (context, index) {
                var notifications = latestNotifications[index];
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                          title: Text(
                            "${notifications['subject']}",
                            maxLines: 2, // Limit to a single line
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('EEE, d MMM y').format(
                                    DateTime.parse(
                                        notifications["dateCreated"])),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Content: ${notifications['content']}',
                                maxLines: 2, // Limit to a single line
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  'NotificationType: ${notifications['notificationType']}')
                            ],
                          ),
                          onTap: () async {}),
                    ),
                  ],
                );
              }),
    );
  }

  Future<void> getNotificationsById() async {
    var user = authController.userInfo.value;
    String userId = user.userId;
    var url = baseUrl + getNotifications(userId);
    try {
      var response =
          await get(Uri.parse(url), headers: await authController.userHeader());

      if (response.statusCode == 200) {
        final responseNotification = jsonDecode(response.body) as Map;
        final result = responseNotification['notifications'] as List;

        print(result);
        // Sort the notifications by date in descending order

        latestNotifications
            .sort((a, b) => b.dateCreated.compareTo(a.dateCreated));

        setState(() {
          latestNotifications = result;
        });
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
