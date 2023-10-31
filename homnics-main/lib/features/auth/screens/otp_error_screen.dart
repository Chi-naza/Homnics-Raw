import 'package:flutter/material.dart';

class OTPErrorScreen extends StatelessWidget {
  static const routeName = '/otp-error-screen';
  const OTPErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                'assets/images/landing/img_error.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24),
              child: Text(
                'Ooppss...',
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
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    Text(
                        'The code is wrong or must have expired. Try requesting for another.'),
                    SizedBox(
                      height: 44,
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Resend OTP'),
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
}
