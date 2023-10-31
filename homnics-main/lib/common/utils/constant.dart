
import 'package:flutter/material.dart';

class Constant {

  static String? validateEmail(String value)
  {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value))
    {
      return "Enter Valid Email";
    } else
    {
      return null;
    }
  }
  static void GoToMainPage(String from, BuildContext context) {
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => MainActivity(from, 0)),
    //         (Route<dynamic> route) => false);
  }
  static String setFirstLetterUppercase(String? value) {
    return value == null || value.isEmpty
        ? ""
        : "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }
}