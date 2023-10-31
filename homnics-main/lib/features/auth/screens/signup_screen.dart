import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:homnics/authentication/controller/authentication_controller.dart';
import 'package:homnics/authentication/models/user_register_request_model.dart';

import 'package:homnics/features/auth/controllers/auth_controller.dart';
import 'package:homnics/features/auth/screens/signin_screen.dart';
import 'package:homnics/features/auth/user_auth/controllers/progressHUD.dart';
import 'package:homnics/features/auth/user_auth/model/sign_up_model.dart';

import '../models/user.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';
  final String? from;
  const SignUpScreen({
    Key? key,
    this.from,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  late SignupRequestModel signupRequestModel;
  bool isApiCallProcess = false;
  AuthenticationController authenticationController =
      AuthenticationController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obsecureText = true;

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
    signupRequestModel = SignupRequestModel();
    emailController.addListener(onListen);
    passwordController.addListener(onListen);
    confirmPasswordController.addListener(onListen);
  }

  @override
  void dispose() {
    emailController.removeListener(onListen);
    emailController.dispose();
    passwordController.removeListener(onListen);
    passwordController.dispose();
    confirmPasswordController.removeListener(onListen);
    confirmPasswordController.dispose();
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
                'assets/images/landing/img_7.png',
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
                'Getting Started',
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
                        onSaved: (input) => signupRequestModel.email = input,
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
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        onSaved: (input) => signupRequestModel.phone = input,
                        autofillHints: [AutofillHints.telephoneNumber],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          prefixIcon: Icon(Icons.phone_android),
                          suffixIcon: phoneController.text.isEmpty
                              ? Container(
                                  width: 0,
                                )
                              : IconButton(
                                  onPressed: () => phoneController.clear(),
                                  icon: Icon(Icons.cancel_outlined)),
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (phone) {
                          if (phone != null && phone.length < 11) {
                            return 'Enter min. 11 characters';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: obsecureText,
                      controller: passwordController,
                      onSaved: (input) => signupRequestModel.password = input,
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
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: obsecureText,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: confirmPasswordController.text.isEmpty
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
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.length < 8) {
                          return 'Password does not match';
                        } else {
                          return null;
                        }
                      },
                    )
                  ],
                ),
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
                        onPressed: () async {
                          if (validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            // await AuthController.signUp(signupRequestModel, context);

                            authenticationController.register(
                                UserRegisterRequestModel(
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    permission: 1100));
                            setState(() {
                              isApiCallProcess = false;
                            });
                          }
                        },
                        child: const Text('Sign Up'),
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
                            onPressed: () {},
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a user?',
                            style: TextStyle(
                              fontSize: 16,
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
                                'Sign In',
                                style: TextStyle(
                                  fontFamily: 'RedHatDisplay',
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                        ],
                      ),
                    )
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
