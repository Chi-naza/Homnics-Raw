import 'package:flutter/material.dart';
import 'package:homnics/features/appointment/models/appointment.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';

import '../../professionals/models/professionals.dart';

class BookingSuccessScreen extends StatefulWidget {
  //static const routeName = '/account-success-screen';
  Appointment appointment;
  Professional professional;
  BookingSuccessScreen(
      {required this.appointment, required this.professional, super.key});

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/landing/checkcircle.png'),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Your appointment has been booked successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            // Container(
            //   height: 100,
            //   width: 250,
            //   child: FittedBox(
            //     child: IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => NavigationScreen()  //AppointmentsHome()
            //                 )
            //                 );
            //       },
            //       icon: Icon(
            //         Icons.arrow_forward_outlined,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
