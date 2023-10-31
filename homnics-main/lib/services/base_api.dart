import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class BaseAPI {
  Future<bool> tokenIsValid() async {
    String token = await getToken();

    var url = baseUrl + getProfessionalsUrl;
    final response = await get(Uri.parse(url), headers: {
      'Accept': 'application/vnd.api.v1+json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("TOKEN IS VALID");
      return true;
    } else {
      print("REFRESHING . . .");
      return await refreshtoken2();
    }
  }

  Future<bool> tokenIsValid2() async {
    return await refreshtoken2();
  }

  refreshToken() async {
    String token = await getToken();

    var url = baseUrl + refreshTokenUrl;
    final response = await post(Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: json.encode({}));

    if (response.statusCode < 400) {
      print("token refresh OK");
      SharedPreferences _pref = await SharedPreferences.getInstance();
      await _pref.setString("user_token", json.decode(response.body)['token']);
      await _pref.setString("updated_at", DateTime.now().toString());
      return true;
    } else {
      print("token refresh failed");
      return false;
    }
  }

  refreshtoken2() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String email = _pref.getString("user_email") ?? '';
    String password = _pref.getString("user_password") ?? '';

    var url = '${baseUrl}${loginUrl}';
    final param = json.encode({
      "email": email,
      "password": password,
    });

    final response = await post(Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
        },
        body: param);

    if (response.statusCode == 200) {
      await _pref.setString("user_token", json.decode(response.body)['token']);
      await _pref.setString("updated_at", DateTime.now().toString());
      print("refreshed");
      return true;
    } else {
      return false;
    }
  }

  getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString("user_token") ?? '';
  }

  myHeaders() async {
    bool valid = await tokenIsValid2();

    if (!valid) {
      print("Invalid TOken");
      return {
        'Accept': 'application/vnd.api.v1+json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ",
      };
    } else {
      String token = await getToken();

      return {
        'Accept': 'application/vnd.api.v1+json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      };
    }
  }

  multipartHeaders() async {
    bool valid = await tokenIsValid2();

    if (!valid) {
      print("Invalid TOken");
      return {
        'Accept': 'application/vnd.api.v1+json',
        'Content-Type': 'multipart/form-data',
        "Authorization": "Bearer ",
      };
    } else {
      String token = await getToken();

      return {
        'Accept': 'application/vnd.api.v1+json',
        'Content-Type': 'multipart/form-data',
        "Authorization": "Bearer $token",
      };
    }
  }

  aPiSnackBar(String msg1) {
    final snackBar = SnackBar(content: Text(msg1));

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
}
