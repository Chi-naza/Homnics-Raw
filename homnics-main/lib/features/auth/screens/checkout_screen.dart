// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:homnics/common/utils/colors.dart';
// import 'package:homnics/common/widgets/number_input_with_increment_decrement.dart';
//
// import '../../payments/controllers/payment_controller.dart';
//
// class CheckOutScreen extends StatefulWidget {
//   static const routeName = '/checkout-screen';
//   final bool isIndividual;
//   final String plan;
//
//   const CheckOutScreen(
//       {super.key, required this.isIndividual, required this.plan});
//
//   @override
//   State<CheckOutScreen> createState() => _CheckOutScreenState();
// }
//
// class _CheckOutScreenState extends State<CheckOutScreen> {
//   bool isSwitch = true;
//   int tabID = 1;
//
//   final MaterialStateProperty<Icon?> thumbIcon =
//       MaterialStateProperty.resolveWith<Icon?>(
//     (Set<MaterialState> states) {
//       // Thumb icon when the switch is selected.
//       if (states.contains(MaterialState.selected)) {
//         return const Icon(Icons.check);
//       }
//       return const Icon(Icons.close);
//     },
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           title: Text(
//             'Confirm Subscription',
//             style: TextStyle(color: textColor),
//           ),
//           actions: [
//             IconButton(
//                 onPressed: null,
//                 icon: SvgPicture.asset('assets/images/landing/X.svg'))
//           ],
//           backgroundColor: appStatusColor,
//           iconTheme: IconThemeData(color: Color(0xFF01232B)),
//         ),
//         backgroundColor: Colors.white,
//         body: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Pay-on-the-go',
//                         style: TextStyle(
//                             color: !isSwitch ? primaryColor : textColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SizedBox(
//                           height: 44,
//                           width: 44,
//                           child: CupertinoSwitch(
//                             activeColor: primaryColor,
//                             trackColor: primaryColor,
//                             value: isSwitch,
//                             onChanged: (bool value) {
//                               setState(() {
//                                 isSwitch = value;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Subscribe & Save',
//                         style: TextStyle(
//                             color: isSwitch ? primaryColor : textColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   isSwitch ? _buildSegment() : Container(),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Color(0xFFE6E9EF),
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(12))),
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 widget.plan,
//                                 style: TextStyle(fontWeight: FontWeight.w500),
//                               ),
//                               TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text('Change'))
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(left: 80.0, bottom: 16),
//                           child: Divider(
//                             thickness: 1,
//                           ),
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(left: 16.0, bottom: 8.0),
//                           child: Row(
//                             children: [
//                               Text(
//                                 '${_buildBodySwitch()}',
//                                 style: TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.w500),
//                               ),
//                               SizedBox(
//                                 width: 16,
//                               ),
//                               Text('for one person'),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(left: 16.0, right: 16.0),
//                           child: Text(
//                               'Check out our health packages and pick the right one for you and your family.'),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: widget.isIndividual
//                               ? Container()
//                               : Row(
//                                   children: [
//                                     NumberInputWithIncrementDecrement(),
//                                     SizedBox(
//                                       width: 8,
//                                     ),
//                                     Text('People')
//                                   ],
//                                 ),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Color(0xFFE6E9EF),
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(12))),
//                     width: double.infinity,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               SvgPicture.asset(
//                                   'assets/images/landing/cross.svg'),
//                               SizedBox(
//                                 width: 16,
//                               ),
//                               Text(
//                                 'Add promo code',
//                                 style: TextStyle(color: primaryColor),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Color(0xFFE6E9EF),
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(12))),
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               left: 16.0, bottom: 8.0, top: 8),
//                           child: Text(
//                             'Summary',
//                             style: TextStyle(
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Individual plan'),
//                               Text('N3,000'),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Total',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                               Text('N3,000'),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 70,
//                   ),
//                   Container(
//                     height: 40,
//                     margin: EdgeInsets.only(left: 16, right: 16),
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                               side: BorderSide(
//                                 color: buttonColor,
//                                 width: 2.0,
//                               ),
//                             ),
//                           ),
//                           backgroundColor:
//                               MaterialStateProperty.all(buttonColor),
//                           textStyle: MaterialStateProperty.all(
//                               TextStyle(fontSize: 30))),
//                       onPressed: () async {
//                         _bottomSheet();
//                       },
//                       child: const Text(
//                         'Subscribe',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: 'RedHatDisplay',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
//
//   _bottomSheet() {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
//       context: context,
//       builder: ((context) => Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     SvgPicture.asset('assets/images/landing/healthsafety.svg'),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.plan,
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.w500),
//                         ),
//                         Text('1  x  N3000')
//                       ],
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
//                   child: Divider(
//                     thickness: 1,
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Color(0xFFE6E9EF),
//                       ),
//                       borderRadius: BorderRadius.all(Radius.circular(12))),
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Select payment method',
//                               style: TextStyle(color: primaryColor),
//                             ),
//                             SizedBox(
//                               width: 16,
//                             ),
//                             SvgPicture.asset(
//                                 'assets/images/landing/arrowright.svg'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                   child: Image.asset(
//                     'assets/images/landing/cards.png',
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
//                   child: Divider(
//                     thickness: 1,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Total',
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     Text(
//                       'N3,000',
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Container(
//                   height: 40,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                             side: BorderSide(
//                               color: buttonColor,
//                               width: 2.0,
//                             ),
//                           ),
//                         ),
//                         backgroundColor: MaterialStateProperty.all(buttonColor),
//                         textStyle:
//                             MaterialStateProperty.all(TextStyle(fontSize: 30))),
//                     onPressed: () async {
//                       await PaymentController().showPaystack(
//                           title: widget.plan,
//                           amount: 500,
//                           email: "ujahmycine@gmail.com",
//                           context: context);
//                     },
//                     child: const Text(
//                       'Proceed To Payment',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: 'RedHatDisplay',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 44,
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
//
//   Widget _buildSegment() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(4)),
//             border: Border.all(color: Color(0xFFF5FFFF))),
//         width: double.infinity,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     tabID = 1;
//                   });
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 17, horizontal: 5),
//                   decoration: segmentDecoration(1),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Monthly', style: segmentText(1)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       tabID = 2;
//                     });
//                   },
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 17, horizontal: 5),
//                     decoration: segmentDecoration(2),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Quarterly', style: segmentText(2)),
//                       ],
//                     ),
//                   )),
//             ),
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     tabID = 3;
//                   });
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 17, horizontal: 5),
//                   decoration: segmentDecoration(3),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Annually', style: segmentText(3)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   segmentDecoration(val) {
//     BorderRadiusGeometry? borderRadius2;
//
//     if (val == 1) {
//       borderRadius2 = const BorderRadius.only(
//           topLeft: Radius.circular(4), topRight: Radius.circular(4));
//     } else if (val == 2) {
//       borderRadius2 = const BorderRadius.only(
//           topLeft: Radius.circular(4), topRight: Radius.circular(4));
//     } else {
//       borderRadius2 = const BorderRadius.only(
//           topLeft: Radius.circular(4), topRight: Radius.circular(4));
//     }
//     return BoxDecoration(
//       border: Border.all(
//           color: tabID == val ? Color(0xFFDEE2E6) : Color(0xFFF5FFFF)),
//       color: tabID == val ? Color(0xFFF5FFFF) : Color(0xFFF5FFFF),
//       borderRadius: borderRadius2,
//     );
//   }
//
//   segmentText(val) {
//     return TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//         color: tabID == val ? Color(0xFF0090B7) : Color(0xFF818182));
//   }
//
//   String _buildBodySwitch() {
//     if (tabID == 1) {
//       return 'N 1000';
//     } else if (tabID == 2) {
//       return 'N 2000';
//     } else {
//       return 'N 3000';
//     }
//   }
// }
