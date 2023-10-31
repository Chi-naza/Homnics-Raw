import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:homnics/features/auth/models/user.dart';
import 'package:homnics/features/auth/screens/auth_screens.dart';
import 'package:homnics/services/base_api.dart';
import 'package:homnics/services/constants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthAPI extends GetxController {
  // base
  BaseAPI base = BaseAPI();
  // user
  final userInfo = User(
    id: '',
    email: '',
    phone: '',
    password: '',
    firstName: '',
    lastName: '',
    address: '',
    emergencyContactName: '',
    emergencyContactPhone: '',
    city: '',
    state: '',
    country: '',
    postalCode: '',
    gender: '',
    emergencyContactRelationship: '',
    dateOfBirth: '',
  ).obs;

  Future<bool> login({required String email, required String password}) async {
    var url = '${baseUrl}${loginUrl}';

    final param = json.encode({
      "email": email,
      "password": password,
    });

    try {
      final response = await post(Uri.parse(url),
          headers: await base.myHeaders(), body: param);
      debugPrint("BODY: ${response.body}");

      if (response.statusCode == 200) {
        var onUser = await getCurrentUser();
        userInfo.value = onUser;
        userInfo.refresh();
        await User.updatelocalUser(onUser);

        debugPrint("STATUS: ${response.statusCode}");
        debugPrint("BODY: ${response.body}");
        debugPrint("USER: $onUser");

        return true;
      }
      base.aPiSnackBar(
        json.decode(response.body)['errors'][0]['message'].toString(),
      );
      print("STATUS: ${response.statusCode}");
    } catch (e) {
      base.aPiSnackBar('Network error: $e');
    }
    return false;
  }

  Future<dynamic> register(User user, BuildContext context) async {
    var url = '${baseUrl}${registerUrl}';
    final param = json.encode(user.toJson());
    final response = await post(Uri.parse(url),
        headers: await base.myHeaders(), body: param);
    debugPrint("STATUS: ${response.statusCode}");
    if (response.statusCode == 201) {
      user.id = json.decode(response.body)['userId'];
      debugPrint("STATUS: ${response.statusCode}");
      await User.updatelocalUser(user);
      return Navigator.of(context).pushReplacementNamed(OTPScreen.routeName);
    }
    base.aPiSnackBar(
        json.decode(response.body)['errors'][0]['message'].toString());
    return false;
  }

  Future<dynamic> confirmEmail(String otp, BuildContext context) async {
    User user = await getCurrentUser();
    var url =
        baseUrl + 'user-api/account/${user.id}/confirm-email/?mobileToken=$otp';
    final param = json.encode({"mobileToken": otp});
    final response = await post(Uri.parse(url),
        headers: await base.myHeaders(), body: param);

    if (response.statusCode == 200) {
      debugPrint("STATUS: ${response.statusCode}");
      //There is no response so we proceed to login s
      return await login(email: user.email, password: user.password);
    }
    debugPrint("STATUS: ${response.statusCode}");
    base.aPiSnackBar(
        json.decode(response.body)['errors'][0]['message'].toString());
    return false;
  }

  Future<User> getUserById(String userId) async {
    var url = baseUrl + getUserByIdUrl(userId);
    final response = await get(Uri.parse(url), headers: await base.myHeaders());

    if (response.statusCode == 200) {
      debugPrint("STATUS: ${response.statusCode}");
      userInfo.value = User.fromJson(json.decode(response.body));
      userInfo.refresh();
      return User.fromJson(json.decode(response.body));
    } else {
      debugPrint("USER NOT GOTTEN ::::: STATUS: ${response.statusCode}");
      debugPrint("USER NOT GOTTEN ::::: BODY: ${response.body}");
      final user = User(
        id: '',
        email: '',
        phone: '',
        password: '',
        firstName: '',
        lastName: '',
        address: '',
        emergencyContactName: '',
        emergencyContactPhone: '',
        city: '',
        state: '',
        country: '',
        postalCode: '',
        gender: '',
        emergencyContactRelationship: '',
        dateOfBirth: '',
      );
      return user;
    }
  }

  Future<User> getCurrentUser() async {
    var url = baseUrl + getCurrentUserUrl();
    final response = await get(Uri.parse(url), headers: await base.myHeaders());

    if (response.statusCode == 200) {
      debugPrint("STATUS: ${response.statusCode}");
      // populating the the user details instance
      userInfo.value = User.fromJson(json.decode(response.body));
      userInfo.refresh();
      debugPrint("GOTTEN USER: ${response.body}");
      debugPrint("GOTTEN USER: $userInfo");
      return User.fromJson(json.decode(response.body));
    } else {
      debugPrint("USER NOT GOTTEN ::::: STATUS: ${response.statusCode}");
      debugPrint("USER NOT GOTTEN ::::: BODY: ${response.body}");
      final user = User(
        id: '',
        email: '',
        phone: '',
        password: '',
        firstName: '',
        lastName: '',
        address: '',
        emergencyContactName: '',
        emergencyContactPhone: '',
        city: '',
        state: '',
        country: '',
        postalCode: '',
        gender: '',
        emergencyContactRelationship: '',
        dateOfBirth: '',
      );
      return user;
    }
  }

  Future<bool> updateUser(
      User user, String userId, BuildContext context) async {
    String genderValue = user.gender;
    String emergencyContactRelationshipValue =
        user.emergencyContactRelationship;

    var url = baseUrl + updateProfileUrl(userId);

    final param = json.encode({
      "firstName": user.firstName,
      "lastName": user.lastName,
      "phoneNumber": user.phone,
      "address": user.address,
      "emergencyContactName": user.emergencyContactName,
      "emergencyContactPhone": user.emergencyContactPhone,
      "city": user.city,
      "state": user.state,
      "country": user.country,
      "postalCode": user.postalCode,
      "gender": genderValue,
      "emergencyContactRelationship": emergencyContactRelationshipValue,
      "dateOfBirth": user.dateOfBirth,
    });

    final response =
        await put(Uri.parse(url), headers: await base.myHeaders(), body: param);

    if (response.statusCode == 200) {
      debugPrint("STATUS: ${response.statusCode}");
      SharedPreferences _pref = await SharedPreferences.getInstance();
      userInfo.value = user;
      userInfo.refresh();

      await _pref.setString("user_phone", user.phone);

      await _pref.setString("user_firstname", user.firstName);

      await _pref.setString("user_lastname", user.lastName);

      base.aPiSnackBar('User updated successfully!');
      return true;
    } else {
      print('User update failed: ${response.statusCode}');
      base.aPiSnackBar('User update failed');
    }

    return false;
  }
  // Future<bool> updateUser(
  //     User user, String userId, BuildContext context) async {
  //   String genderValue = user.gender;
  //   String emergencyContactRelationshipValue =
  //       user.emergencyContactRelationship;

  //   var url = baseUrl + updateProfileUrl(userId);

  //   final param = json.encode({
  //     "firstName": user.firstName,
  //     "lastName": user.lastName,
  //     "phoneNumber": user.phone,
  //     "address": user.address,
  //     "emergencyContactName": user.emergencyContactName,
  //     "emergencyContactPhone": user.emergencyContactPhone,
  //     "city": user.city,
  //     "state": user.state,
  //     "country": user.country,
  //     "postalCode": user.postalCode,
  //     "gender": genderValue,
  //     "emergencyContactRelationship": emergencyContactRelationshipValue,
  //     "dateOfBirth": user.dateOfBirth,
  //   });

  //   final response =
  //       await put(Uri.parse(url), headers: await myHeaders(), body: param);

  //   if (response.statusCode == 200) {
  //     debugPrint("STATUS: ${response.statusCode}");
  //     SharedPreferences _pref = await SharedPreferences.getInstance();

  //     await _pref.setString("user_phone", user.phone);

  //     await _pref.setString("user_firstname", user.firstName);

  //     await _pref.setString("user_lastname", user.lastName);

  //     await _pref.setString("updated_at", DateTime.now().toString());

  //     await _pref.setString("user_address", user.address);

  //     await _pref.setString("address", user.address);

  //     await _pref.setString("emergencyContactName", user.emergencyContactName);

  //     await _pref.setString(
  //         "emergencyContactPhone", user.emergencyContactPhone);

  //     await _pref.setString("city", user.city);

  //     await _pref.setString("state", user.state);

  //     await _pref.setString("country", user.country);

  //     await _pref.setString("postalCode", user.postalCode);

  //     await _pref.setString("dateOfBirth", user.dateOfBirth);

  //     aPiSnackBar('User updated successfully!', context);
  //     return true;
  //   } else {
  //     print('User update failed: ${response.statusCode}');
  //     aPiSnackBar('User update failed', context);
  //   }

  //   return false;
  // }

  Future<bool> saveAvatar(String userId, File? avatar) async {
    if (avatar == null || userId.isEmpty) {
      return false;
    }

    var url = baseUrl + getAvatarUrl(userId);
    final headers = await base.multipartHeaders();

    dio.FormData formData = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(avatar.path,
          filename: avatar.path.split('/').last),
    });

    final response = await dio.Dio().post(
      url,
      data: formData,
      options: dio.Options(headers: headers),
    );

    if (response.statusCode == 200) {
      debugPrint("STATUS: ${response.statusCode}");
      return true;
    }

    debugPrint("STATUS: ${response.statusCode}");

    print('Avatar upload failed: ${response.statusCode}');

    return false;
  }
}
