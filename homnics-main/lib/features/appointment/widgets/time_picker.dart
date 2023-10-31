import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimePickerOptions extends StatefulWidget {
  const TimePickerOptions({
    super.key,
  });

  @override
  State<TimePickerOptions> createState() => _TimePickerOptionsState();
}

class _TimePickerOptionsState extends State<TimePickerOptions> {
  TimeOfDay? selectedTime;
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  Orientation? orientation;
  TextDirection textDirection = TextDirection.ltr;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    child: const Text('Select Time'),
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                        initialEntryMode: entryMode,
                        //orientation: orientation,
                        builder: (BuildContext context, Widget? child) {
                          // We just wrap these environmental changes around the
                          // child in this builder so that we can apply the
                          // options selected above. In regular usage, this is
                          // rarely necessary, because the default values are
                          // usually used as-is.
                          return Theme(
                            data: Theme.of(context).copyWith(
                              materialTapTargetSize: tapTargetSize,
                            ),
                            child: Directionality(
                              textDirection: textDirection,
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat: use24HourTime,
                                ),
                                child: child!,
                              ),
                            ),
                          );
                        },
                      );
                      // 'Selected DateTime: ${DateTime(chosenDate!.year, chosenDate!.month, chosenDate!.day, chosenTime!.hour, chosenTime!.minute)}'
                      SharedPreferences _pref =
                          await SharedPreferences.getInstance();
                      _pref.setString('temp_appointment_time', time.toString());
                      setState(() {
                        selectedTime = time;
                      });
                    },
                  ),
                ),
                if (selectedTime != null)
                  Text('Selected time: ${selectedTime!.format(context)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
