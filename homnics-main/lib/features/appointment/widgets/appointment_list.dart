import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/utils/colors.dart';
import '../../../common/utils/scale_size.dart';
import '../../professionals/models/professionals.dart';
import '../controllers/appointmentController.dart';
import '../models/meeting.dart';
import '../screens/meetingpoint.dart';
import 'ecg_loader.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  // List<Appointment> latestAppointment = [];
  List latestAppointment = [];
  bool isLoading = true;
  Professional? professional;
  @override
  void initState() {
    getData();
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
        if (latestAppointment.isEmpty)
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
                // Image.asset('assets/images/landing/not_found.jpg'),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    textScaleFactor: ScaleSize.textScaleFactor(context),
                    "No Upcoming Appointments",
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
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 5.5, top: 10),
          child: ListView.builder(
              itemCount: latestAppointment.length,
              itemBuilder: (BuildContext context, int index) {
                var appointment = latestAppointment[index];
                DateTime parsedDate = DateTime.parse(appointment['appointmentDate']);

                 // Format the DateTime as a string with the desired time format
                String formattedDateTime = DateFormat('yyyy-MM-dd hh:mm a').format(parsedDate);
              
                // if(appointment['appointmentStatus'] != 'Pending'){
                //   return Container();
                // }
                return Card(
                  //color: appBarColor,
                  child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 22.0),
                        child: Text("${appointment['appointmentStatus']}"),
                      ),
                      //Icon(Icons.star),
                      title: Text("Name of Doctor"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${appointment["planBeneficiaryDto"]['fullName']}'),
                          Text('Date: ${formattedDateTime}')
                        ],
                      ),
                      // trailing: Padding(
                      //   padding: const EdgeInsets.only(top:32.0),
                      //   child: Icon(Icons.arrow_forward),
                      // ),
                      onTap: () async {
                        Meeting? meeting = await AppointmentController()
                            .fixMeeting(appointment['id']);
                        String url = meeting?.meetingLink ?? '';
                        if (url.isNotEmpty) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => MeetingPoint(meeting: meeting!)));
                        }
                      }),
                );
              }),
        ),
      ],
    );
  }

  Future<void> getData() async {
    latestAppointment =
        await AppointmentController().getAllAppointments(context);
    setState(() {
      isLoading = false;
    });
  }
}
