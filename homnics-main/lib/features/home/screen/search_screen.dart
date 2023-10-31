// import 'package:flutter/material.dart';
// import 'package:homnics/common/utils/colors.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:homnics/features/appointment_booking/appointment_details_screen.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: appBarColor,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         leading: Padding(
//             padding: const EdgeInsets.all(
//               8.0,
//             ),
//             child: GestureDetector(
//                onTap: () {
//                     Navigator.pop(context);
//                   },
//               child: Icon(
//                 Icons.arrow_back_ios_new,
//                 color: iconsColor,
//               ),
//             )),
//         title: Align(
//           alignment: Alignment.center,
//           child: Text(
//             "Book Appointment",
//             style: TextStyle(
//               color: textColor,
//               fontSize: 16,
//               fontFamily: 'RedHatDisplay',
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Icon(
//               Icons.close,
//               color: iconsColor,
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Flexible(
//                     //flex: 1,
//                     child: SizedBox(
//                       height: 48,
//                       child: TextField(
//                         cursorColor: Colors.grey,
//                         textAlign: TextAlign.left,
//                         decoration: InputDecoration(
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           hintText: 'Search',
//                           hintStyle: TextStyle(
//                             color: Colors.grey,
//                             //fontSize: 16,
//                           ),
//                           prefixIcon: Icon(
//                             Icons.search,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     AppointmentDetailsScreen()));
//                     },
//                     child: Container(
//                         margin: EdgeInsets.only(left: 15),
//                         // padding: EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Icon(Icons.equalizer),
//                         width: 25),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 100,
//               ),
//               Center(
//
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   child: Image.network(
//
//                     'https://img.freepik.com/free-vector/product-hunt-concept-illustration_114360-594.jpg?w=740&t=st=1682880433~exp=1682881033~hmac=b9894cae0da79adfe0ccdd3b437d66e118a190795b49f30f116750d6152057d9'),
//                 ),
//               ),
//            // Image.asset('assets/images/landing/not_found.jpg'),
//             SizedBox(
//               height: 10,
//             ),
//             Center(
//               child: Text(
//                 "Sorry! No result found :(",
//                 style: TextStyle(
//                   color: greyColor,
//                   fontSize: 20,
//                   fontFamily: 'RedHatDisplay',
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//               // Padding(
//               //   padding: const EdgeInsets.only(bottom: 64.0),
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       GestureDetector(
//               //         onTap: () {
//               //           Navigator.push(
//               //               context,
//               //               MaterialPageRoute(
//               //                   builder: (context) =>
//               //                       AppointmentDetailsScreen()));
//               //         },
//               //         child: Padding(
//               //           padding: const EdgeInsets.only(top: 24.0, bottom: 16),
//               //           child: Row(
//               //             children: [
//               //               CircleAvatar(
//               //                 radius: 30.0,
//               //                 backgroundImage: NetworkImage(
//               //                     "https://images.pexels.com/photos/5327585/pexels-photo-5327585.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
//               //                 backgroundColor: Colors.transparent,
//               //                 child: Stack(children: [
//               //                   Align(
//               //                     alignment: Alignment.bottomRight,
//               //                     child: CircleAvatar(
//               //                       radius: 9,
//               //                       backgroundColor: Colors.white70,
//               //                       child: Container(
//               //                         height: 12,
//               //                         width: 12,
//               //                         child: Image.asset(
//               //                             'assets/images/landing/is_active.png'),
//               //                       ),
//               //                     ),
//               //                   ),
//               //                 ]),
//               //               ),
//               //               SizedBox(
//               //                 width: 20,
//               //               ),
//               //               Column(
//               //                 crossAxisAlignment: CrossAxisAlignment.start,
//               //                 children: [
//               //                   Text(
//               //                     'Optician',
//               //                     textAlign: TextAlign.left,
//               //                     style: TextStyle(
//               //                         fontSize: 14,
//               //                         fontFamily: 'RedHatDisplay',
//               //                         fontWeight: FontWeight.w500,
//               //                         color: greyColor),
//               //                   ),
//               //                   Text(
//               //                     'Dr. Ben Odukoya',
//               //                     textAlign: TextAlign.left,
//               //                     style: TextStyle(
//               //                         fontSize: 16,
//               //                         fontFamily: 'RedHatDisplay',
//               //                         fontWeight: FontWeight.w500,
//               //                         color: iconsColor),
//               //                   ),
//               //                   Row(
//               //                     crossAxisAlignment: CrossAxisAlignment.start,
//               //                     children: [
//               //                       Container(
//               //                         height: 20,
//               //                         child: RatingBar.builder(
//               //                           initialRating: 3,
//               //                           minRating: 1,
//               //                           direction: Axis.vertical,
//               //                           allowHalfRating: true,
//               //                           itemCount: 4,
//               //                           // itemPadding:
//               //                           //     EdgeInsets.symmetric(horizontal: 2.0),
//               //                           itemBuilder: (context, _) => Icon(
//               //                             Icons.star,
//               //                             color: Colors.amber,
//               //                           ),
//               //                           onRatingUpdate: (rating) {
//               //                             print(rating);
//               //                           },
//               //                         ),
//               //                       ),
//               //                       Text(
//               //                         '(124)',
//               //                         textAlign: TextAlign.left,
//               //                         style: TextStyle(
//               //                             fontSize: 12,
//               //                             fontFamily: 'RedHatDisplay',
//               //                             fontWeight: FontWeight.w500,
//               //                             color: greyColor),
//               //                       ),
//               //                     ],
//               //                   ),
//               //                 ],
//               //               ),
//               //             ],
//               //           ),
//               //         ),
//               //       ),
//
//
//
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
