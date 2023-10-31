import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HealthTipsCarousel extends StatefulWidget {
  @override
  _HealthTipsCarouselState createState() => _HealthTipsCarouselState();
}

class _HealthTipsCarouselState extends State<HealthTipsCarousel> {
  final List<String> healthTips = [
    "Drink plenty of water throughout the day.",
    "Get at least 7-8 hours of sleep every night.",
    "Eat a balanced diet rich in fruits and vegetables.",
    "Engage in regular physical activity for 30 minutes.",
    "Practice mindfulness and stress-relief techniques.",
    "Limit processed foods and sugary drinks."
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: healthTips.length,
      options: CarouselOptions(
        autoPlay: true,
        autoPlayCurve: Curves.decelerate,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(milliseconds: 500),
        enlargeCenterPage: true,
        aspectRatio: 28 / 9, // You can adjust this aspect ratio
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              healthTips[index],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}



// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class HealthTipsCarousel extends StatefulWidget {
//   @override
//   _HealthTipsCarouselState createState() => _HealthTipsCarouselState();
// }
// class _HealthTipsCarouselState extends State<HealthTipsCarousel> {
//   final List<String> healthTips = [
//     "Drink plenty of water throughout the day.",
//     "Get at least 7-8 hours of sleep every night.",
//     "Eat a balanced diet rich in fruits and vegetables.",
//     "Engage in regular physical activity for 30 minutes.",
//     "Practice mindfulness and stress-relief techniques.",
//     "Limit processed foods and sugary drinks."
//   ];

//   final List<String> imageUrls = [
//     "https://plus.unsplash.com/premium_photo-1661582247705-a7ac30acd485?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
//     "https://example.com/sleep_image.jpg",
//     "https://example.com/diet_image.jpg",
//     "https://example.com/exercise_image.jpg",
//     "https://example.com/mindfulness_image.jpg",
//     "https://example.com/processed_food_image.jpg",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider.builder(
//       itemCount: healthTips.length,
//       options: CarouselOptions(
//         autoPlay: true,
//         autoPlayInterval: Duration(seconds: 3),
//         autoPlayAnimationDuration: Duration(milliseconds: 800),
//         enlargeCenterPage: true,
//         aspectRatio: 16 / 9,
//       ),
//       itemBuilder: (BuildContext context, int index, int realIndex) {
//         return Container(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.network(
//                 imageUrls[index],
//                 height: 200, // Adjust image height as needed
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 healthTips[index],
//                 style: TextStyle(fontSize: 18.0),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
