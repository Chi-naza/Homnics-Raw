import 'package:flutter/material.dart';

import '../../../common/utils/colors.dart';
import '../../../common/utils/scale_size.dart';
import '../../appointment/widgets/ecg_loader.dart';
import 'notification_controller.dart';


class NotificationsFilter extends StatefulWidget {
  const NotificationsFilter({ Key? key}) : super(key: key);

  @override
  State<NotificationsFilter> createState() => _NotificationsFilterState();
}

class _NotificationsFilterState extends State<NotificationsFilter> {
  // List<notifications> latestNotifications = [];
  List latestNotifications = [];
  bool isLoading = true;
  var notificationsUpdateResponse = NotificationsController().notificationUpdate();
  @override
  void initState() {
    getData();
    notificationsUpdateResponse;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        alignment: Alignment.center,

        //replace this with a loading icon
        // child: new CircularProgressIndicator(),
        child: EcgLoadingWidget(),
      );
    }

    return Column(
      children: [
        if (latestNotifications.isEmpty)
          Container(
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
                    textScaleFactor: ScaleSize.textScaleFactor(context),
                    "No Upcoming notificationss",
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
        Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 21),
          child: ListView.builder(
              itemCount: latestNotifications.length,
              itemBuilder: (BuildContext context, int index) {
                var notifications = latestNotifications[index];

                return Card(
                  child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 22.0),
                        child: Text("${notifications['notificationsStatus']}"),
                      ),
                      //Icon(Icons.star),
                      title: Text("Name of Doctor"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${notifications["planBeneficiaryDto"]['email']}'),
                          Text('Date: ${notifications['notificationsDate']}')
                        ],
                      ),
                      onTap: () async {
                        // Meeting? meeting = await notificationsController()
                        //     .fixMeeting(notifications['id']);
                        // String url = meeting?.meetingLink ?? '';
                        // if (url.isNotEmpty) {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (_) => MeetingPoint(meeting: meeting!)
                        //       )
                        //       );
                        // }
                      }),
                );
              }),
        ),
      ],
    );
  }

  Future<void> getData() async {
  try {
    var notificationsResponse = await NotificationsController().getNotificationsById();
    if (notificationsResponse != null) {
      setState(() {
        latestNotifications = notificationsResponse.notifications!; // Assuming notifications is a list in the NotificationResponse class
        isLoading = false;
      });
    } else {
      // Handle case where notificationsResponse is null or empty
      setState(() {
        latestNotifications = [];
        isLoading = false;
      });
    }
  } catch (error) {
    // Handle error
    setState(() {
      latestNotifications = [];
      isLoading = false;
    });
  }
}

}