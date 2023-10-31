// import 'package:flutter/material.dart';
// import 'package:homnics/features/notifications/screens/tips_screen.dart';

// import '../widgets/widgets.dart';

// class RecommendationsScreen extends StatefulWidget {
//   const RecommendationsScreen({super.key});

//   @override
//   State<RecommendationsScreen> createState() => _RecommendationsScreenState();
// }

// class _RecommendationsScreenState extends State<RecommendationsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Recommendations"),
//         ),
//         body: Column(
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Container(
//                       child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Image.asset(
//                           'assets/images/landing/rec_img.png',
//                         ),
//                         Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 20.0, left: 40),
//                                 child: Text(
//                                   "Healthy steps",
//                                   style: TextStyle(fontWeight: FontWeight.w500),
//                                   //style: CustomTextStyles.titleLargeGray900,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 40, top: 8),
//                                 // padding: getPadding(
//                                 //   top: 3,
//                                 // ),
//                                 child: Text(
//                                   "02/08/2022",
//                                   //style: CustomTextStyles.bodyMediumGray600,
//                                 ),
//                               ),
//                               HealthTipsCarousel(),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 45, top: 20),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.bookmarks_outlined,
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               TipsScreen()));
//                                 },
//                                 child: Icon(
//                                   Icons.send_outlined,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ]))
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//           ],
//         )
//         );
//   }
// }
