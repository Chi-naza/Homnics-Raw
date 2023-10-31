import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/auth/screens/auth_screens.dart';
import 'package:homnics/features/auth/screens/signin_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class SlidersScreen extends StatefulWidget {
  static const routeName = '/sliders-screen';

  const SlidersScreen({super.key});

  @override
  _SlidersScreenState createState() => _SlidersScreenState();
}

class _SlidersScreenState extends State<SlidersScreen> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  var orientation, size, height, width;

  @override
  void initState() {
    super.initState();
    // chooseScreen();
    //initialization();
  }

  void initialization() async {
    // Delay to simulate splash screen effect (remove this part if not needed)
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();

    // Navigate to NavigationScreen if user_email is not null
    // if (email != null) {
    //    FlutterNativeSplash.remove();
    //   Navigator.pushReplacementNamed(context, NavigationScreen.routeName);
    // } else {
    //   // Initialize the splash screen and show sliderWidget
    //   FlutterNativeSplash.remove();
    //   setState(() {}); // Trigger a rebuild to show the sliderWidget
    // }
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    // print('ready in 2...');
    // await Future.delayed(const Duration(seconds: 1));
    // print('ready in 1...');
    // await Future.delayed(const Duration(seconds: 1));
    // print('go!');
    // FlutterNativeSplash.remove();

    // chooseScreen();
  }

  final List<Map<String, String>> slideItemList = [
    {
      'image': 'assets/images/landing/img_1.png',
      'header': 'Access to healthcare just got easier and more affordable',
      'message': 'Scroll to see more benefits for you →'
    },
    {
      'image': 'assets/images/landing/img_2.png',
      'header':
          'Secure and personalised conversations with qualified health experts',
      'message': ''
    },
    {
      'image': 'assets/images/landing/img_3.png',
      'header': 'Find the best doctors, hospitals near you',
      'message': ''
    },
    {
      'image': 'assets/images/landing/img_4.png',
      'header': '24/7 Support right at your fingertips',
      'message': ''
    }
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    const landscapeBrakepoints = [
      ResponsiveBreakpoint.resize(480, name: MOBILE, scaleFactor: 0.6),
      ResponsiveBreakpoint.resize(520, name: MOBILE, scaleFactor: 0.6),
      ResponsiveBreakpoint.resize(600, name: TABLET, scaleFactor: 0.8),
      ResponsiveBreakpoint.autoScale(800, name: TABLET, scaleFactor: 0.8),
      ResponsiveBreakpoint.resize(1000, name: DESKTOP, scaleFactor: 1.1),
      ResponsiveBreakpoint.autoScale(1200, name: DESKTOP, scaleFactor: 1.1),
      ResponsiveBreakpoint.autoScale(2460, name: '4K', scaleFactor: 1.7),
    ];
    orientation = MediaQuery.of(context).orientation;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return sliderWidget(context);
  }

  Scaffold sliderWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/landing/img.png',
                height: 24,
                width: 27,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Homnics",
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(color: appBarColor),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CarouselSlider(
              items: slideItemList
                  .map((item) => Builder(builder: (context) {
                        return Container(
                          width: double.infinity,
                          color: appBarColor,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 50, right: 50),
                                  child: Text(
                                    item['header']!,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontFamily: 'RedHatDisplay',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                SizedBox(
                                  height: 300,
                                  width: 250,
                                  child: ClipPath(
                                    child: ClipRRect(
                                      child: Image.asset(
                                        item['image']!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    child: Text(
                                      item['message']!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 16,
                                        fontFamily: 'RedHatDisplay',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
                  .toList(),
              carouselController: _controller,
              options: CarouselOptions(
                  viewportFraction: 1.0,
                  height: double.infinity,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Positioned(
              // bottom: 260,
              top: MediaQuery.of(context).size.height * 0.7,
              left: MediaQuery.of(context).size.width * 0.4,
              right: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: slideItemList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Color(0xFF2ED6FD)
                                  : Color(0xFF0090B7))
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 24, right: 24),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                color: buttonColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(buttonColor),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 30))),
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RedHatDisplay',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => NavigationScreen()));
                          // },
                          child: Text(
                            'Already a user?',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'RedHatDisplay',
                              fontWeight: FontWeight.w400,
                            ),
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
          ],
        ),
      ),
    );
  }

  // void chooseScreen() async {
  //   //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   //  email = _pref.getString('user_email');
  //   //   print('Hello >>>>>>, $email');

  //   //if token is empty and email and passwords are not empty. it mean registeration is incomplete

  //   // Navigator.of(context).pushNamed(OTPScreen.routeName);
  //   // Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
  //   //if token is empty and everything is empty (unregistered).
  // }
}
