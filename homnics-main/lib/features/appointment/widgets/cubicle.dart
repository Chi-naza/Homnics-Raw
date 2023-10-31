import 'package:flutter/material.dart';


class Cubicle extends StatelessWidget {
  String item;
  Cubicle({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
        // color: Colors.black12,
        // border: Border.all(
        //   color: secondaryFillColor,
        //   width: 1.0,
        // ),
        borderRadius: BorderRadius.circular(21.0),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: FittedBox(
            child: Text(
              item + ";",
              textAlign: TextAlign.center,
              style: TextStyle(
                  //color: secondaryFillColor,
                  fontSize: 13,
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w400),
              // style: TextStyle(
              //     fontSize: 16, color: greyColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
