import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:homnics/authentication/controller/authentication_controller.dart';
import 'package:homnics/authentication/models/user_register_response_model.dart';

import 'package:homnics/features/auth/screens/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/utils/colors.dart';
import '../controllers/auth_api.dart';

import '../user_auth/model/sign_up_model.dart';
import 'account_success_screen.dart';
import 'otp_error_screen.dart';

class OTPScreen extends StatefulWidget {
  static const routeName = '/otp-screen';
  final registeredUserResponse;
  const OTPScreen({
    Key? key,
    this.registeredUserResponse,

    //required this.userId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OTPScreenState();
  }
}

class OTPScreenState extends State<OTPScreen> {
  //var users = [];
  TextEditingController otpController = TextEditingController();
  String otpValue = '';
  //late SignupRequestModel signupRequestModel;
  late UserRegisterResponseModel userRegisterResponseModel;
  AuthenticationController authenticationController =
      AuthenticationController();

  String email = '';

  @override
  void initState() {
    super.initState();
    //initialization();
    userRegisterResponseModel = widget.registeredUserResponse;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("REGISTERED USER RESPONSE ID : ${userRegisterResponseModel.userId}");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/landing/img_9.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24),
              child: Text(
                'Enter OTP',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24),
              child: Column(
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: 'Check ',
                    ),
                    TextSpan(
                        text: '$email',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: ' inbox for the verification code',
                    )
                  ])),
                  // Text( 'Enter your registered email address to receive the reset link.'),

                  SizedBox(
                    height: 16,
                  ),
                  OtpTextField(
                    onSubmit: (value) {
                      otpValue = value;
                    },

                    // onCodeChanged: (value) {
                    //   otpValue = value;
                    // },

                    borderColor: Colors.black,
                    focusedBorderColor: buttonColor,
                    enabledBorderColor: Color(0xFF294B53),
                    showFieldAsBox: true,
                    numberOfFields: 4,
                    borderWidth: 1,
                    fieldWidth: 50,
                    fillColor: Colors.white,
                    filled: true,
                    margin: EdgeInsets.all(12),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          print("    ");
                          print(otpValue);
                          if (otpValue.isNotEmpty && otpValue.length == 4) {
                            processOTP();
                          } else {
                            Navigator.pushNamed(
                                context, OTPErrorScreen.routeName);
                          }
                        },
                        child: const Text('Verify OTP'),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn’t receive the code?',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            },
                            child: Text(
                              'Resend OTP',
                              style: TextStyle(
                                fontFamily: 'RedHatDisplay',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Wrong OTP',
                        style: TextStyle(
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> processOTP() async {
    bool isValid = await authenticationController.confirmEmail(
        userRegisterResponseModel.userId, otpValue);
    isValid
        ? Navigator.pushNamed(context, AccountSuccessScreen.routeName)
        : Navigator.pushNamed(context, OTPErrorScreen.routeName);
  }
}
