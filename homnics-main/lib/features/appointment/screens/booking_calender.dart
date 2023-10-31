import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';

import 'availableProfessionals.dart';

class BookingsCalender extends StatefulWidget {
  const BookingsCalender({super.key});

  @override
  State<BookingsCalender> createState() => _BookingsCalenderState();
}

class _BookingsCalenderState extends State<BookingsCalender> {
  List<DateTime?> chosenDate = [
    DateTime.now(),
  ];

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
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: iconsColor,
              ),
            ),
          ),
        ),
        title: Text(
          "Book Appointment",
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontFamily: 'RedHatDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDefaultSingleDatePickerWithValue(),
              SizedBox(
                height: 120,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 2,
                  ),
                  onPressed: (() {
                    processNext();
                  }),
                  child: Text('Next'))
            ],
          ),
        ),
      ),
    );
  }
  //  getValueText(
  //   CalendarDatePicker2Type datePickerType,
  //   List<DateTime?> values,
  // ) {
  //   values =
  //       values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
  //   var valueText = (values.isNotEmpty ? values[0] : null)
  //       .toString()
  //       .replaceAll('00:00:00.000', '');

  //   if (datePickerType == CalendarDatePicker2Type.multi) {
  //     valueText = values.isNotEmpty
  //         ? values
  //             .map((v) => v.toString().replaceAll('00:00:00.000', ''))
  //             .join(', ')
  //         : 'null';
  //   } else if (datePickerType == CalendarDatePicker2Type.range) {
  //     if (values.isNotEmpty) {
  //       final startDate = values[0].toString().replaceAll('00:00:00.000', '');
  //       final endDate = values.length > 1
  //           ? values[1].toString().replaceAll('00:00:00.000', '')
  //           : 'null';
  //       valueText = '$startDate to $endDate';
  //     } else {
  //       return 'null';
  //     }
  //   }

  //   return valueText;
  // }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      
      selectedDayHighlightColor: primaryColor,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      //TODO : this arrow back button still functions i just changed the color
      lastMonthIcon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      weekdayLabelTextStyle: const TextStyle(
        color: textColor,
        fontSize: 16,
        fontFamily: 'RedHatDisplay',
        fontWeight: FontWeight.w500,
      ),
      firstDayOfWeek: 1,
      //todo : change this alignment to center
      controlsHeight: 50,

      controlsTextStyle: const TextStyle(
        color: textColor,
        fontSize: 16,
        fontFamily: 'RedHatDisplay',
        fontWeight: FontWeight.w500,
      ),
      dayTextStyle: const TextStyle(
        color: greyColor,
        fontWeight: FontWeight.normal,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Color(0xB59E9E9E),
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 1)))
          .isNegative,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: const Text(
            'Select your preferred date',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 18),
        CalendarDatePicker2(
          config: config,
          value: chosenDate,
          onValueChanged: (dates) {
            setState(() => chosenDate = dates);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: getTime(),
        ),
        SizedBox(
          height: 10,
        ),
        if (selectedTime != null)
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Text(
                'Selected Date Time is: ${intl.DateFormat('yyyy-MM-dd HH:MM').format(chosenDate.first!)}'),
          ),
      ],
    );
  }

  TimeOfDay? selectedTime;
  TextDirection textDirection = TextDirection.ltr;
  Widget getTime() {
    return ElevatedButton(
      child: const Text('Select Time'),
      onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.dial,
          // orientation: orientation,
          builder: (BuildContext context, Widget? pikin) {
            // We just wrap these environmental changes around the
            // child in this builder so that we can apply the
            // options selected above. In regular usage, this is
            // rarely necessary, because the default values are
            // usually used as-is.
            return Theme(
              data: Theme.of(context).copyWith(
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
              child: Directionality(
                // textDirection: TextDirection.LTR,
                textDirection: textDirection,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    alwaysUse24HourFormat: false,
                  ),
                  child: pikin!,
                ),
              ),
            );
          },
        );
        chosenDate.first = DateTime(
            chosenDate.first!.year,
            chosenDate.first!.month,
            chosenDate.first!.day,
            time!.hour,
            time.minute);

        setState(() {
          selectedTime = time;
        });
      },
    );
  }

  Future<void> processNext() async {
    String formattedDate =
        intl.DateFormat('yyyy-MM-dd').format(chosenDate.first!);
    print(formattedDate);
  String formattedTime = intl.DateFormat('h:mm a').format(DateTime(chosenDate.first!.year, chosenDate.first!.month, chosenDate.first!.day, selectedTime!.hour, selectedTime!.minute));

    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString("new_appointment_date", formattedDate);
    await _pref.setString("new_appointment_Time", formattedTime);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AvailableProfessionalScreen(date: formattedDate)));
  }
}
