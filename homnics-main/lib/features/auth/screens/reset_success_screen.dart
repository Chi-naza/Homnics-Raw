import 'package:flutter/material.dart';

class ResetSuccessScreen extends StatefulWidget {
  static const routeName = '/resetsuccess-screen';
  const ResetSuccessScreen({super.key});

  @override
  State<ResetSuccessScreen> createState() => _ResetSuccessScreenState();
}

class _ResetSuccessScreenState extends State<ResetSuccessScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(onListen);
  }

  @override
  void dispose() {
    emailController.removeListener(onListen);
    emailController.dispose();

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              child: Image.asset('assets/images/landing/img_6.png'),
            ),
            SizedBox(
              height: 67,
            ),
            Container(
              height: 60,
              width: 284,
              child: Text(
                'Your password has been successfully changed',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final isValidForm = formKey.currentState!.validate();
                  if (isValidForm) {
                    Navigator.pushReplacementNamed(
                        context, ResetSuccessScreen.routeName);
                  }
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
