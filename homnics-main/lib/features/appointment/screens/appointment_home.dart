import 'package:flutter/material.dart';
import 'package:homnics/features/appointment/widgets/appointment_list.dart';

class AppointmentsHome extends StatelessWidget {
  const AppointmentsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: AppointmentList(),
      ),
    );
  }
}
