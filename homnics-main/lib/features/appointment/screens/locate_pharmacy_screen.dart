import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LocatePharmacyScreen extends StatefulWidget {
  const LocatePharmacyScreen({super.key});

  @override
  State<LocatePharmacyScreen> createState() => _LocatePharmacyScreenState();
}

class _LocatePharmacyScreenState extends State<LocatePharmacyScreen> {
  //  CalendarController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = CalendarController();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          //backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: 
           GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              //color: iconsColor,
            ),
          
        ),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Coming Soon...",
              style: TextStyle(
                //color: textColor,
                fontSize: 18,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
         backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            CachedNetworkImage(imageUrl: 
            'https://img.freepik.com/free-vector/house-restyling-concept-illustration_114360-2819.jpg?w=740&t=st=1682284727~exp=1682285327~hmac=fbb1a5162ce2258abe553a04349d2cc7cd0abbda003de1bf0f7e27c01590c3ff',
            ),
           
           // Image.asset('assets/images/landing/not_found.jpg'),
            SizedBox(
              height: 20,
            ),
            Text(
              "This feature is coming soon. \n keep an eye out",
              textAlign: TextAlign.center,
              style: TextStyle(
                //color: textColor,
                
                fontSize: 16,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        );
  }
}
