import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/appointment/models/appointment.dart';
import 'package:homnics/features/services/helper_functions.dart';
import 'package:homnics/services/base_api.dart';
import 'package:http/http.dart';

import '../../../services/constants.dart';
import '../../professionals/models/professionals.dart';
import '../models/meeting.dart';

class AppointmentController extends BaseAPI {
  // plan controller
  var userPlanController = Get.find<UsersPlanController>();

  bookAppointment(Appointment appointment, BuildContext context) async {
    var url = baseUrl + postAppointmentURL;
    var params = json.encode(appointment.toJson());
    print(params);
    var response =
        await post(Uri.parse(url), headers: await myHeaders(), body: params);
    print("========${response.body}");
    print(":::::${response.statusCode}");

    if (response.statusCode < 400) {
      return true;
    }

    return false;
  }

  getAppointmentByStatus(BuildContext context, int status) async {
    String beneficiaryId = await userPlanController.getPlanBeneficiarId();
    var url =
        'https://api.homnics.com/user-api/appointment/by-status/beneficiary/$beneficiaryId?status=$status&pageNumber=1&pageSize=1000';
    // baseUrl + getAppointmentByBeneficiaryStatus(beneficiaryId, status);
    try {
      var response = await get(Uri.parse(url), headers: await myHeaders());
      //print(response.statusCode);

      var result = json.decode(response.body);

      if (response.statusCode < 400) {
        // print("loading");
        // print(result);
        return result['appointments'];
        //return Appointment.appointmentsFromJson(result['appointments']);
      }
    } catch (error) {
      print("The error is ::: ${error}");
      return [];
    }
  }

  fixMeeting(String appointmentId) async {
    var url = baseUrl + fixMeetingUrl;
    var params = json.encode({"appointmentId": appointmentId});
    var response =
        await post(Uri.parse(url), headers: await myHeaders(), body: params);
    var result = json.decode(response.body);
    if (response.statusCode < 400) {
      print(result);
      // navigate from here
      return Meeting.fromJson(result);
    }
    print(result);
    return [];
  }

  static DateTime getNearestDate(List<String> days) {
    List<int> open = convertWeekdaysToNumbers(days);
    DateTime today = DateTime.now();
    int minDay = findNearestValidDay(open, today.weekday);
    DateTime nearestValidDay;

    if (today.weekday <= minDay) {
      nearestValidDay = today.subtract(Duration(days: today.weekday - minDay));
    } else {
      nearestValidDay =
          today.add(Duration(days: DateTime.friday + (7 - minDay)));
    }

    print('The nearest Friday is: $nearestValidDay');

    return nearestValidDay;
  }

  static bool validDays(DateTime dateTime, List<String> days) {
    List<int> open = convertWeekdaysToNumbers(days);
    if (open.contains(dateTime.weekday)) {
      return true;
    } else {
      return false;
    }
  }

  getAllAppointments(BuildContext context) async {
    print("here");
    var url = baseUrl +
        getAllAppointmentUrl(
          await userPlanController.getPlanBeneficiarId(),
        );

    var response = await get(Uri.parse(url), headers: await myHeaders());
    var result = json.decode(response.body);
    if (response.statusCode < 400) {
      print(result['appointments']);
      return result['appointments'];
      return Appointment.appointmentsFromJson(result['appointments']);
    }
    return [];
  }

  geAvailableProfessionals(BuildContext context, String date) async {
    String url = baseUrl +
        getAvailableProfessionals +
        'pageNumber=1&pageSize=10&appointmentDate=$date';
    try {
      var response = await get(Uri.parse(url), headers: await myHeaders());
      var result = json.decode(response.body);
      if (response.statusCode < 400) {
        List<Professional> professionals =
            await Professional.professionalsFromJson(result['professionals']);
        print("The length of professionals is : ${professionals.length}");

        return professionals;
      }
    } catch (error) {}
  }
}
