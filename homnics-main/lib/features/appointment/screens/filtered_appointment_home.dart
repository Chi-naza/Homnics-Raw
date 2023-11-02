import 'package:flutter/material.dart';
import 'package:homnics/features/appointment/widgets/appointment_list.dart';

import '../widgets/appointment_list_filter.dart';

class FiltteredAppointmentsHome extends StatelessWidget {
  const FiltteredAppointmentsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Appointments"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: AppointmentListFilter(
            status: 2,
          ),
        ),
      ),
    );
  }
}
