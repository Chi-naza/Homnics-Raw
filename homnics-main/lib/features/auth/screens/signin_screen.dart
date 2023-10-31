import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homnics/authentication/controller/authentication_controller.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/auth/controllers/auth_api.dart';

import 'package:homnics/features/auth/screens/reset_password_screen.dart';

import '../../home/screen/navigation_screen.dart';

import '../user_auth/controllers/progressHUD.dart';
import '../user_auth/model/sign_in_model.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signin-screen';

  const SignInScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  late SigninRequestModel signinRequestModel;
  bool _isCheck = false;
  bool isApiCallProcess = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obsecureText = true;

  //var authenticationController = Get.find<AuthenticationController>();
  AuthenticationController authenticationController =
      AuthenticationController();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  void initState() {
    super.initState();
    signinRequestModel = SigninRequestModel();
    emailController.addListener(onListen);
    passwordController.addListener(onListen);

    //   if(_isCheck == true){
    //  Navigator.pushReplacementNamed(context, NavigationScreen.routeName);

    //     }
  }

  @override
  void dispose() {
    emailController.removeListener(onListen);
    emailController.dispose();
    passwordController.removeListener(onListen);
    passwordController.dispose();
    super.dispose();
  }

  void onListen() => setState(() {});

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/landing/img_5.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24),
              child: Text(
                'Welcome',
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
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => signinRequestModel.email = input,
                        autofillHints: [AutofillHints.email],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          prefixIcon: Icon(Icons.mail),
                          suffixIcon: emailController.text.isEmpty
                              ? Container(
                                  width: 0,
                                )
                              : IconButton(
                                  onPressed: () => emailController.clear(),
                                  icon: Icon(Icons.cancel_outlined)),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: obsecureText,
                      controller: passwordController,
                      onSaved: (input) => signinRequestModel.password = input,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: passwordController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                onPressed: () => setState(() {
                                  obsecureText = !obsecureText;
                                }),
                                icon: obsecureText
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              ),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.length < 8) {
                          return 'Enter min. 8 characters';
                        } else {
                          return null;
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ResetPasswordScreen.routeName);
                },
                child: Text('Reset password'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24),
              child: Row(
                children: [
                  Checkbox(
                    activeColor: primaryColor,
                    value: _isCheck,
                    onChanged: (value) {
                      setState(() {
                        _isCheck = value!;
                      });
                    },
                  ),
                  Text('Keep me signed in'),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
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
                        onPressed: () async {
                          if (validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });

                            // Login function
                            await authenticationController.login(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            setState(() {
                              isApiCallProcess = false;
                            });
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('or sign in with'),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, NavigationScreen.routeName);
                            },
                            icon: Image.asset(
                                'assets/images/landing/img_12.png')),
                        IconButton(
                            onPressed: null,
                            icon: Image.asset(
                                'assets/images/landing/img_11.png')),
                        IconButton(
                            onPressed: null,
                            icon: Image.asset(
                                'assets/images/landing/img_10.png')),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
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

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
