import 'package:flutter/material.dart';
import 'package:homnics/common/utils/colors.dart';
import 'package:homnics/features/home/screen/navigation_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendations"),
      ),
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        scrollPhysics: BouncingScrollPhysics(),
        pages: [
          PageViewModel(
              titleWidget: Text(
                "Limit Unhealthy Foods and Eat Healthy Meals",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              body:
                  "Do not forget to eat breakfast and choose a nutritious meal with more protein and fiber and less fat, sugar, and calories",
              image: Image.asset(
                "assets/images/landing/tip2.jpg",
                height: 400,
                width: 400,
              )),
          PageViewModel(
              titleWidget: Text(
                "Measure and Watch Your Weight",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              body:
                  "Keeping track of your body weight on a daily or weekly basis will help you see what you’re losing and/or what you’re gaining.",
              image: Image.asset(
                "assets/images/landing/tip1.jpg",
                height: 400,
                width: 400,
              )),
          
          PageViewModel(
              titleWidget: Text(
                "Take Multivitamin Supplements",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              body:
                  "To make sure you have sufficient levels of nutrients, taking a daily multivitamin supplement is a good idea, especially when you do not have a variety of vegetables and fruits at home.",
              image: Image.asset(
                "assets/images/landing/tip3.jpg",
                height: 400,
                width: 400,
              )),
          PageViewModel(
              titleWidget: Text(
                "Drink Water and Stay Hydrated, and Limit Sugared Beverages ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              body:
                  "Drink water regularly to stay healthy, but there is NO evidence that drinking water frequently (e.g. every 15 minutes) can help prevent any viral infection.",
              image: Image.asset(
                "assets/images/landing/tip4.jpg",
                height: 400,
                width: 400,
              )),
        ],
        onDone: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NavigationScreen()));
        },
        onSkip: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NavigationScreen()));
        },
        showBackButton: true,
        back: Icon(
          Icons.arrow_back,
          color: primaryColor,
        ),
        next: Icon(
          Icons.arrow_forward,
          color: primaryColor,
        ),
        done: Text(
          "Done",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
        ),
        dotsDecorator: DotsDecorator(
            size: Size.square(10),
            activeSize: Size(20.0, 10.0),
            color: greyColor,
            activeColor: primaryColor,
            spacing: EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
      ),
    );
  }
}
