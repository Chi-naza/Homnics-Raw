import 'package:flutter/material.dart';

class DesignConfig {

  static const BoxShadow boxShadow = BoxShadow(
    color: Colors.black12,
    offset: Offset(3, 3),
    blurRadius: 5,
  );

  static Widget ButtonWithShadowNew(String btntext, BuildContext context) {
    return Container(
      height: 55,
      width: double.maxFinite,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(
            10,
          )),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff0090B7),
              Color(0xff0090B7),
            ],
          )),
      child: Center(
          child: Text(btntext,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.merge(const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'RedHatDisplay')))),
    );
  }
  static BoxDecoration BoxDecorationContainer(Color color, double radius) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
    );
  }
  static BoxDecoration BoxDecorationBorderContainer(
      Color bcolor, double radius) {
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: bcolor),
      boxShadow: const [
        boxShadow,
      ],
    );
  }
}