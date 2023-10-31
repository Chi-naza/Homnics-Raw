import 'dart:convert';

import 'package:get/get.dart';
import 'package:homnics/services/base_api.dart';
import 'package:http/http.dart';

import '../../../services/constants.dart';
import '../../HealthPlans/controllers/UserPlanController.dart';
import '../model/notification_request.dart';
import '../model/notification_response.dart';

class NotificationsController extends BaseAPI {
  var userPlanController = Get.find<UsersPlanController>();

  Future<NotificationResponse?> getNotificationsById() async {
    String userId = await userPlanController.getActivePlanId();
    var url = baseUrl + getNotifications(userId);
    try {
      var response = await get(Uri.parse(url), headers: await myHeaders());

      if (response.statusCode == 200) {
        print(response.body);
        NotificationResponse notificationResponse =
            NotificationResponse.fromJson(jsonDecode(response.body));
        print("notificationsResponse : ${notificationResponse.notifications}");
        return notificationResponse;
      } else {
        return NotificationResponse();
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<UpdateNotification?> notificationUpdate() async {
    String userId = await userPlanController.getActivePlanId();

    var url = baseUrl + updateNotifications;

    try {
      var response = await put(Uri.parse(url));

      if (response.statusCode == 200) {
        UpdateNotification updateNotification =
            UpdateNotification.fromJson(jsonDecode(response.body));
        updateNotification.id = userId;
        updateNotification.read = true;
      }
    } catch (error) {}
    return null;
  }
}
