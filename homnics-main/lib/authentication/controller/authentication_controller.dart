import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/authentication/models/current_logged_in_user_model.dart';
import 'package:homnics/authentication/models/update_user_request_model.dart';
import 'package:homnics/authentication/models/user_register_request_model.dart';
import 'package:homnics/authentication/models/user_register_response_model.dart';
import 'package:homnics/features/auth/models/user.dart';
import 'package:homnics/features/auth/screens/otp_screen.dart';
import 'package:homnics/features/auth/screens/signin_screen.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';
import 'package:homnics/services/constants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends GetxController {
  // user
  final userInfo = CurrentLoggedInUserModel(
    userId: '',
    email: '',
    phone: '',
    firstName: '',
    lastName: '',
    fullName: '',
    avatar: '',
    isActive: false,
    identityDocument: '',
    professionalLicence: '',
    permissions: [],
    address: '',
    city: '',
    country: '',
    postalCode: '',
    state: '',
    dateOfBirth: DateTime.now(),
    gender: '',
    emergencyContactName: '',
    emergencyContactPhone: '',
    emergencyContactRelationship: '',
  ).obs;

  //LOGIN USER

  Future<bool> login({required String email, required String password}) async {
    var url = '${baseUrl}${loginUrl}';

    final param = json.encode({
      "email": email,
      "password": password,
    });

    try {
      final response = await post(Uri.parse(url),
          headers: {
            'Accept': 'application/vnd.api.v1+json',
            'Content-Type': 'Application/json',
            // "Authorization": "Bearer $token",
          },
          body: param);
      debugPrint("BODY: ${response.body}");
      var decodedResp = jsonDecode(response.body);

      if (response.statusCode == 200) {
        SharedPreferences _pref = await SharedPreferences.getInstance();

        await _pref.setString("user_token", decodedResp['token']);

        debugPrint("STATUS: ${response.statusCode}");
        debugPrint("BODY: ${response.body}");
        debugPrint("SAVED TOKEN: ${decodedResp['token']}");
        // debugPrint("USER: $onUser");

        await getCurrentLoggedInUser();

        aPiSnackBar(
          'Login Successfull. Welcome',
        );
        Get.to(NavigationScreen());

        return true;
      }
      aPiSnackBar(
        json.decode(response.body)['errors'][0]['message'].toString(),
      );
      print("STATUS: ${response.statusCode}");
    } catch (e) {
      aPiSnackBar('Network error: $e');
    }
    return false;
  }

  //REGISTER USER

  register(UserRegisterRequestModel userRegisterRequestModel) async {
    var url = '${baseUrl}${registerUrl}';
    final param = json.encode(userRegisterRequestModel.toJson());
    final response = await post(Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'Application/json',
          // "Authorization": "Bearer $token",
        },
        body: param);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      var returnedData = UserRegisterResponseModel.fromJson(responseData);
      // saving user data
      await saveUserData(
        id: returnedData.userId,
        email: returnedData.email,
        password: userRegisterRequestModel.password,
        token: '',
      );
      await fetchUserData();
      print("USER ID IS : ${returnedData.userId}");
      Get.to(OTPScreen(
        registeredUserResponse: returnedData,
      ));
      return returnedData;
    }
    aPiSnackBar(
      json.decode(response.body)['errors'][0]['message'].toString(),
    );
    return false;
  }

  // CONFIRM EAMIL BY RECEIVING OTP

  Future<dynamic> confirmEmail(String userId, String otp) async {
    var url =
        baseUrl + 'user-api/account/${userId}/confirm-email?mobileToken=$otp';
    final param = json.encode({"mobileToken": otp});
    final response = await post(Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'Application/json',
          // "Authorization": "Bearer $token",
        },
        body: param);

    if (response.statusCode == 200) {
      debugPrint("STATUS: ${response.statusCode}");
      //There is no response so we proceed to login s
      return Get.to(SignInScreen());
    }
    debugPrint("STATUS: ${response.statusCode}");
    aPiSnackBar(json.decode(response.body)['errors'][0]['message'].toString());
    return false;
  }

  Future<User> getCurrentUser() async {
    var url = baseUrl + getCurrentUserUrl();
    final response =
        await get(Uri.parse(url), headers: {}); // await base.myHeaders());

    if (response.statusCode == 200) {
      debugPrint("STATUS: ${response.statusCode}");
      // populating the the user details instance s
      // userInfo.value = User.fromJson(json.decode(response.body));
      // userInfo.refresh();
      debugPrint("GOTTEN USER: ${response.body}");
      // debugPrint("GOTTEN USER: $userInfo");
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

  // CUSTOM SNACKBAR

  aPiSnackBar(String msg1) {
    final snackBar = SnackBar(content: Text(msg1));
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  //SAVING USER DATA

  saveUserData(
      {required String id,
      required String email,
      required String password,
      required String token}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    id.isNotEmpty ? await _pref.setString("user_id", id) : null;
    await _pref.setString("user_email", email);
    await _pref.setString("user_password", password);
    await _pref.setString("user_token", token);
  }

  // FETCHING USER DATA

  Future<(String, String, String, String)> fetchUserData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String id = await _pref.getString("user_id") ?? '';
    String email = _pref.getString("user_email") ?? '';
    String password = _pref.getString("user_password") ?? '';
    String token = await _pref.getString("user_token") ?? '';

    print("ID : $id");
    print("EMAIL : $email");
    print("PASSWORD : $password");
    print("TOKEN : $token");

    return (id, email, password, token);
  }

  // for getting token in header

  userHeader() async {
    var (userId, email, password, token) = await fetchUserData();
    return {
      'Accept': 'application/vnd.api.v1+json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };
  }

  //UPDATING USER DETAILS
  Future<void> updateUserInformation(
      UpdateUserRequestModel updateUserRequestModel) async {
    var (userId, email, password, token) = await fetchUserData();
    print("Id : $userId");

    // var url = baseUrl + "user-api/account/${userId}/profile";
    var url = baseUrl + updateProfileUrl(userId);

    try {
      var response = await put(
        Uri.parse(url),
        headers: await {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'Application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(updateUserRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        Get.to(NavigationScreen());
        aPiSnackBar("Successfully updated user information!");
        print("Updated user successfully navigate to home screen");
      } else {
        aPiSnackBar("Failed to update user information!");
        print(
            "Failed to update user information. Status code: ${response.statusCode}");
        print("Update Failed Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // GETTING CURRENT LOGGED IN USER DETAILS
  Future<CurrentLoggedInUserModel> getCurrentLoggedInUser() async {
    var url = baseUrl + getCurrentUserUrl();
    // var (userId, email, password, token) = await fetchUserData();

    SharedPreferences _pref = await SharedPreferences.getInstance();

    var toKen = await _pref.getString("user_token") ?? '';
    try {
      final response = await get(
        Uri.parse(url),
        headers: await {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'Application/json',
          "Authorization": "Bearer $toKen",
        },
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        var returnedData = CurrentLoggedInUserModel.fromJson(json);
        userInfo.value = returnedData;
        userInfo.refresh();

        print("RETURNED DATA : $returnedData");
        print("USER INFO : $returnedData");
        return returnedData;
      } else {
        throw Exception('Empty response: No user data available.');
      }
    } catch (e) {
      // Handle exceptions (e.g., network errors) here.
      print('Error: $e');
      return throw (e);
    }
  }
}
