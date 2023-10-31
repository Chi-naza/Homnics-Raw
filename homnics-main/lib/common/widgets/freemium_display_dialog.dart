import 'package:flutter/material.dart';
import 'package:homnics/common/utils/colors.dart';


import '../../features/notifications/widgets/widgets.dart';

class FreemiumDisplayDialog extends StatelessWidget {
   final title;
  const FreemiumDisplayDialog({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
     String formattedDate = "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}";
      print("Current Date: $formattedDate");
    return Dialog(
      shadowColor: primaryColor,
      elevation: 30,
      insetAnimationCurve: Curves.linearToEaseOut,
      backgroundColor: appBarColor.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        height: 220,
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                       
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 28),
                                child: Text(
                                  "Upgrade Plan!",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                  //style: CustomTextStyles.titleLargeGray900,
                                ),
                              ),
                            
                              Padding(
                                padding: EdgeInsets.all(28),
                                child: Text("Kindly upgrade your plan before booking appointment.",
                                textAlign: TextAlign.left,
                                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                   GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right:18.0),
                                      child: Text("Skip", style: TextStyle(
                                        fontWeight: FontWeight.bold,color: primaryColor
                                        ),),
                                    ),
                                  ),
                                 
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right:18.0),
                                      child: Text("Skip", style: TextStyle(
                                        fontWeight: FontWeight.bold,color: primaryColor
                                        ),),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      
                      ]))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )
      ),
      // title: Text("Health Tips"),
      // content: Text(title),
      // actions: [
      //   ElevatedButton(onPressed: null, child: Text("data"))
      // ],
    );
  }
  String _twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  } else {
    return "0$n";
  }
}
}