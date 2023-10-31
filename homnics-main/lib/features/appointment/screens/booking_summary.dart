import 'package:flutter/material.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/appointment/controllers/appointmentController.dart';
import 'package:homnics/features/appointment/models/appointment.dart';
import 'package:homnics/features/appointment/screens/appointment_success_screen.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';

import '../../professionals/models/professionals.dart';
import '../../professionals/widgets/professional_head.dart';

class BookingSummary extends StatefulWidget {
  Professional professional;
  Appointment appointment;
  BookingSummary(
      {required this.professional, required this.appointment, super.key});

  @override
  State<BookingSummary> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    additionalInfoController.text =
        widget.appointment.additionalInfo ?? "No additonal Info";
    //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    additionalInfoController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
       // backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: iconsColor,
              ),
            )),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Book Appointment",
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
               Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => NavigationScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: iconsColor,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: ProfessionalHeader(
                professional: widget.professional,
              )),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                          color: secondaryFillColor,
                        ),
                        FittedBox(
                          child: Text(
                            (widget.appointment.appointmentDate
                                    ?.split(" ")
                                    .first) ??
                                "No Date",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                                color: secondaryFillColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(width: 60.0),
                  // Expanded(
                  //   flex: 1,
                  //   child: Column(
                  //     children: [
                  //       Icon(
                  //         Icons.access_time_outlined,
                  //         size: 20,
                  //         color: secondaryFillColor,
                  //       ),
                  //       Text(
                  //         '5:00 pm',
                  //         style: TextStyle(
                  //             fontSize: 16,
                  //             fontFamily: 'RedHatDisplay',
                  //             fontWeight: FontWeight.w400,
                  //             color: secondaryFillColor),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    width: 60.0,
                  ),
                  if (widget.appointment.appointmentFormat > 1)
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Icon(
                            Icons.videocam_outlined,
                            size: 20,
                            color: secondaryFillColor,
                          ),
                          Text(
                            'Video',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                                color: secondaryFillColor),
                          )
                        ],
                      ),
                    ),
                  if (widget.appointment.appointmentFormat < 2)
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 20,
                            color: secondaryFillColor,
                          ),
                          Text(
                            'Video',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                                color: secondaryFillColor),
                          )
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 38,
              ),
              Text(
                'Symptoms ',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                    color: iconsColor),
              ),
              SizedBox(
                height: 12,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: 33,
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //     color: secondaryFillColor,
                      //     width: 1.0,
                      //   ),
                      //   borderRadius: BorderRadius.circular(100.0),
                      // ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            widget.appointment.symptoms ??
                                "No symptom specified",
                            style: TextStyle(
                                color: secondaryFillColor,
                                fontSize: 16,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity, // <-- TextField width
                height: 96,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: secondaryFillColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ), // <-- TextField height
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: additionalInfoController,
                    maxLines: null,
                    readOnly: true,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Additional Info'),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Set a reminder so you stay on track (Optional)',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'RedHatDisplay',
                    fontWeight: FontWeight.w500,
                    color: iconsColor),
              ),
              SizedBox(
                height: 12,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 116,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: secondaryFillColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            '1 hour before',
                            style: TextStyle(
                                color: secondaryFillColor,
                                fontSize: 13,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 116,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: secondaryFillColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            '3 hours before',
                            style: TextStyle(
                                color: secondaryFillColor,
                                fontSize: 13,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 90,
                      height: 33,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: secondaryFillColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            '1 day before',
                            style: TextStyle(
                                color: secondaryFillColor,
                                fontSize: 13,
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 33,
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        bool isBooked = await AppointmentController()
                            .bookAppointment(widget.appointment, context);
                        isBooked
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingSuccessScreen(
                                          professional: widget.professional,
                                          appointment: widget.appointment,
                                        )))
                            : null;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Confirm booking',
                          style: TextStyle(
                            color: appBarColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            fontFamily: 'RedHatDisplay',
                          ),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
