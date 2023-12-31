import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../common/utils/colors.dart';
import '../controllers/appointmentController.dart';
import '../models/meeting.dart';
import '../screens/meetingpoint.dart';
import 'ecg_loader.dart';

class AppointmentListFilter extends StatefulWidget {
  final int? status;
  const AppointmentListFilter({this.status = 0, Key? key}) : super(key: key);

  @override
  State<AppointmentListFilter> createState() => AppointmentListFilterState();
}

class AppointmentListFilterState extends State<AppointmentListFilter> {
  List latestAppointment = [];
  bool isLoading = false;

  @override
  void initState() {
    refreshData(widget.status!);
    super.initState();
  }

  Future<void> refreshData(int status) async {
    if (status != 0) {
      setState(() {
        isLoading = true;
      });
      latestAppointment =
          await AppointmentController().getAppointmentByStatus(context, status);
    } else {
      latestAppointment =
          await AppointmentController().getAllAppointments(context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: 100,
        alignment: Alignment.topCenter,
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
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "No Appointments Here",
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
            padding: EdgeInsets.only(bottom: 61, top: 10, left: 2, right: 2),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      var appointment = latestAppointment[index];
                      String appointmentDate = appointment['appointmentDate'];
                      DateTime parsedDate = DateTime.parse(appointmentDate);
                      String formattedDate =
                          DateFormat('MMM dd, yyyy hh:mm a').format(parsedDate);

                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: InkWell(
                          onTap: () async {
                            Meeting? meeting = await AppointmentController()
                                .fixMeeting(appointment['id']);
                            String url = meeting?.meetingLink ?? '';
                            if (url.isNotEmpty) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      MeetingPoint(meeting: meeting!)));
                            }
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: InkWell(
                                      onTap: () async {},
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: greyColor,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          shape: BoxShape.rectangle,
                                          color: appBarColor,
                                        ),
                                        child: Icon(
                                          Icons.calendar_month_outlined,
                                          size: 18,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'You have a ${appointment['appointmentStatus']} appointment:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w500,
                                          color: secondaryFillColor,
                                        ),
                                      ),
                                      Text(
                                        '${appointment['professionalName']}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w400,
                                          color: iconsColor,
                                        ),
                                      ),
                                      Text(
                                        'Date: ${formattedDate}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'RedHatDisplay',
                                          fontWeight: FontWeight.w500,
                                          color: greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Divider(color: greyColor),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: latestAppointment.length,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}



// ListView.builder(
//               itemCount: latestAppointment.length,
//               itemBuilder: (BuildContext context, int index) {
//                 var appointment = latestAppointment[index];
//                 String appointmentDate = appointment['appointmentDate'];
//                 DateTime parsedDate = DateTime.parse(appointmentDate);
//                 String formattedDate =
//                     DateFormat('MMM dd, yyyy hh:mm a').format(parsedDate);

//                 return Padding(
//                   padding: const EdgeInsets.only(
//                     top: 16.0,
//                   ),
//                   child: InkWell(
//                     onTap: () async {
//                       Meeting? meeting = await AppointmentController()
//                           .fixMeeting(appointment['id']);
//                       String url = meeting?.meetingLink ?? '';
//                       if (url.isNotEmpty) {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (_) => MeetingPoint(meeting: meeting!)));
//                       }
//                     },
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8),
//                               child: InkWell(
//                                 onTap: () async {},
//                                 child: Container(
//                                   height: 32,
//                                   width: 32,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: greyColor,
//                                         width: 1.0,
//                                       ),
//                                       borderRadius: BorderRadius.circular(16),
//                                       shape: BoxShape.rectangle,
//                                       color: appBarColor),
//                                   child: Icon(
//                                     Icons.calendar_month_outlined,
//                                     size: 18,
//                                     color: primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'You have a ${appointment['appointmentStatus']} appointment:',
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontFamily: 'RedHatDisplay',
//                                       fontWeight: FontWeight.w500,
//                                       color: secondaryFillColor),
//                                 ),
//                                 Text(
//                                   '${appointment['professionalName']}',
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontFamily: 'RedHatDisplay',
//                                       fontWeight: FontWeight.w400,
//                                       color: iconsColor),
//                                 ),
//                                 Text(
//                                   'Date: ${formattedDate}',
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontFamily: 'RedHatDisplay',
//                                       fontWeight: FontWeight.w500,
//                                       color: greyColor),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 8.0,
//                         ),
//                         Divider(color: greyColor),
//                       ],
//                     ),
//                   ),
//                 );
//               }),