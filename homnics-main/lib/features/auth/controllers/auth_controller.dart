import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/features/HealthPlans/controllers/UserPlanController.dart';
import 'package:homnics/features/auth/controllers/auth_api.dart';
import 'package:homnics/features/auth/user_auth/model/sign_up_model.dart';

import '../models/user.dart';

import '../screens/signin_screen.dart';
import '../user_auth/api/api_service.dart';

class AuthController {
  static signUp(
      SignupRequestModel signupRequestModel, BuildContext context) async {
    signupRequestModel.permission = 1100;
    APIService apiService = new APIService();

    SignupResponseModel value = await apiService.register(signupRequestModel);

    if (value.token.isNotEmpty) {
      final snackBar = SnackBar(content: Text("Login Successful"));
      Navigator.pushNamed(context, SignInScreen.routeName);

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(content: Text("Try Again!"));
      SnackBar(content: Text(value.error));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static signUp2(User user, BuildContext context) async {
    await AuthAPI().register(user, context);
  }

  static update(String userId, User user, BuildContext context) async {
    await AuthAPI().updateUser(user, userId, context);
  }

  static saveAvatar(String userId, File? avatar) async {
    await AuthAPI().saveAvatar(userId, avatar);
  }
}
