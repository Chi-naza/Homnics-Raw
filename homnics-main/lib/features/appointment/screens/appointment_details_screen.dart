import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/appointment/models/appointment.dart';
import 'package:homnics/features/appointment/screens/booking_calender.dart';
import 'package:homnics/features/appointment/screens/booking_summary.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../professionals/models/professionals.dart';
import '../../professionals/widgets/professional_head.dart';
import '../models/symptoms.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  Professional professional;

  AppointmentDetailsScreen({required this.professional, super.key});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  BookingsCalender bookingsCalender = BookingsCalender();
  TextEditingController timeInputController = TextEditingController();
  TextEditingController formatInputController = TextEditingController();
  TextEditingController symptomController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();
  List<Symptom> symptoms = Symptom.symptoms;
  List<Symptom> selectedSymptoms = [];
  String my_symptoms = '';
  String selectedDate = '';
  String formatedTime = '';
  String remindAt = '';
  int? selectedFormat = 1;

  final currentPlanId = "".obs;
  var apppointmentFormat = [
    {
      "Id": 2,
      "name": "Audio",
    },
    {"id": 1, "name": "Video"}
  ];

  Color _container1Color = Colors.transparent;
  Color _container2Color = Colors.transparent;

  bool _isVisible = true;

  //final BookingsCalender datesFormat = BookingsCalender();

  @override
  void initState() {
    getData();
    //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("PLAN ID : $currentPlanId");
    print(dateinput.text);
    print(UsersPlanController().getPlanBeneficiarId());
    return Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 35),
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () {
                processData();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Book',
                  style: TextStyle(
                    color: appBarColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    fontFamily: 'RedHatDisplay',
                  ),
                ),
              )),
        ),
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
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    //  color: iconsColor,
                  ),
                ),
              )),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Book Appointment",
              style: TextStyle(
                //color: textColor,
                fontSize: 16,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.close,
                  //color: iconsColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        //backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _container1Color = primaryColor;
                          _container2Color = Colors.transparent;
                        });
                      },
                      child: Container(
                          width: 112,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: secondaryFillColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                              color: _container1Color),
                          child: Text(timeinput.text)),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _container2Color = primaryColor;
                          _container1Color = Colors.transparent;
                        });
                      },
                      child: Container(
                          width: 82,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: secondaryFillColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                              color: _container2Color),
                          child: Text(formatedTime)),
                    ),
                    SizedBox(
                      width: 0.0,
                    ),
                    SizedBox(height: 20),
                    Visibility(
                      visible: false,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // _container2Color = primaryColor;
                            // _container1Color = Colors.transparent;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: secondaryFillColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                            //color: _container2Color
                          ),
                          child: DropdownButton<Map<String, dynamic>>(
                            value: apppointmentFormat.firstWhere(
                                (format) => format['id'] == selectedFormat),
                            hint: Text('Format'),
                            onChanged: (Map<String, dynamic>? newValue) {
                              setState(() {
                                selectedFormat = newValue!['id'];
                              });
                            },
                            items: apppointmentFormat
                                .map((Map<String, dynamic> option) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: option,
                                child: Text(option['name']),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 38,
                  ),
                  Text(
                    'How are you feeling? (optional)',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      //color: iconsColor
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 33,
                    // width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: symptoms.length,
                        itemBuilder: (_, index) {
                          Symptom symptom = symptoms[index];
                          // bool inTheList = false;
                          return GestureDetector(
                              onTap: () {
                                onSymptomTap(symptom);

                                setState(() {});
                              },
                              child: Container(
                                width: 90,
                                height: 33,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: inSelectedSymptoms(symptom)
                                      ? primaryColor
                                      : Colors.transparent,
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
                                    child: FittedBox(
                                      child: Text(
                                        symptom.description,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            //color: secondaryFillColor,
                                            fontSize: 13,
                                            fontFamily: 'RedHatDisplay',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        }),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  Text(
                    'Additional info (optional)',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      //color: iconsColor
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // <-- TextField width
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
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a message'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  Text(
                    'Reviews',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'RedHatDisplay',
                      fontWeight: FontWeight.w500,
                      //color: iconsColor
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'George',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w500,
                                    //color: iconsColor
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.vertical,
                                    allowHalfRating: true,
                                    itemCount: 4,
                                    itemSize: 20.0,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 240,
                              height: 72,
                              child: Text(
                                'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w500,
                                    color: greyColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(color: greyColor),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'George',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w500,
                                      color: iconsColor),
                                ),
                                Container(
                                  height: 20,
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.vertical,
                                    allowHalfRating: true,
                                    itemCount: 4,
                                    itemSize: 20.0,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 240,
                              height: 72,
                              child: Text(
                                'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w500,
                                    color: greyColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(color: greyColor),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'George',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w500,
                                      color: iconsColor),
                                ),
                                Container(
                                  height: 20,
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.vertical,
                                    allowHalfRating: true,
                                    itemCount: 4,
                                    itemSize: 20.0,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 240,
                              height: 72,
                              child: Text(
                                'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'RedHatDisplay',
                                    fontWeight: FontWeight.w500,
                                    color: greyColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(color: greyColor),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  onSymptomTap(Symptom symptom) {
    inSelectedSymptoms(symptom)
        ? selectedSymptoms.remove(symptom)
        : selectedSymptoms.add(symptom);

    selectedSymptoms.forEach((element) {
      my_symptoms = my_symptoms + element.description + ", ";
    });
  }

  inSelectedSymptoms(Symptom symptom) {
    if (selectedSymptoms.contains(symptom)) {
      return true;
    }

    return false;
  }

  Future<void> processData() async {
    String beneficiaryId;
    try {
      beneficiaryId = await UsersPlanController().getPlanBeneficiarId();
    } catch (error) {
      // Handle the error, e.g., show an error message
      print("Error while fetching beneficiary ID: $error");
      return;
    }
    // DateTime parsedTime = DateFormat('hh:mm a').parse(timeinput.text);
    // String formattedTime = DateFormat('HH:mm').format(parsedTime);
    final body = {
      "planBeneficiaryId": beneficiaryId,
      "professionalId": widget.professional.id,
      "appointmentStatus": 1,
      "appointmentFormat": selectedFormat,
      "appointmentDate": dateinput.text,
      "cancellationReason": "",
      "symptoms": my_symptoms,
      "additionalInfo": additionalInfoController.text,
      "beneficiaryRemindDate": remindAt,
      "professionalRemindDate": remindAt
    };

    Appointment appointment = Appointment.fromJson(body);
    if (selectedFormat != null) {
      // && remindAt != null
      // Perform the comparison or calculation /// for now it cant be null
      if (selectedFormat == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookingSummary(
                      professional: widget.professional,
                      appointment: appointment,
                      dateInput: timeinput.text,
                      timeInput: formatedTime,
                    )));
      }
    } else {
// Handle the case where one of the variables is null
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Format selectd pending.. keep an eye out"),
          duration: Duration(
              seconds: 2), // Duration for which the toast should be visible
        ),
      );
    }
  }

  Future<void> getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    dateinput.text = _pref.getString("new_appointment_date") ?? '';
    timeinput.text = _pref.getString("new_appointment_Time") ?? '';
    // planId = _pref.getString("health_plan_id") ?? '';

    currentPlanId.value = (await _pref.getString("health_plan_id"))!;
    print("CURRENT PLAN : $currentPlanId");
    formatedTime = _pref.getString("new_appointment_formatted_time") ?? '';

    symptoms = Symptom.symptoms;
    setState(() {});
  }

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
