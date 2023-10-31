import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:homnics/common/utils/colors.dart';

import '../../features/notifications/screens/tips_screen.dart';
import '../../features/notifications/widgets/widgets.dart';

class HealthTipsWidget extends StatelessWidget {
   final title;
  const HealthTipsWidget({super.key, this.title});

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
                                    const EdgeInsets.only(top: 20.0, left: 43),
                                child: Text(
                                  "Daily Tips",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                  //style: CustomTextStyles.titleLargeGray900,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 43, top: 8),
                              
                                child: Text(
                                  "$formattedDate",
                                  //style: CustomTextStyles.bodyMediumGray600,
                                ),
                              ),
                              HealthTipsCarousel(),

                              Row(
                                children: [
                                  Spacer(),
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