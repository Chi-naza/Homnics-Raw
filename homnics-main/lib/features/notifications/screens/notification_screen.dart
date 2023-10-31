import 'package:flutter/material.dart';
import 'package:homnics/common/utils/colors.dart';
import '../widgets/widgets.dart';
import 'notifications_filter.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification-screen';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
   
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int tabID = 1;
  bool isSwitch = true;
  List latestAppointment = [];
  bool isLoading = true;
  
  String dropdownValue = 'Appointments';
  String selectedOption = 'Appointments';

  Widget getAppointmentsWidget() {
    return Container(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSwitch ? _buildSegment() : Container(),
            Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, bottom: 8.0, right: 2),
                child: Column(
                  children: [
                    Container(
                      child: _buildNotificationsBodySwitch(),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget getCurrentWidget() {
    
      return getAppointmentsWidget();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          //backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new,
                //color: iconsColor,
              ),
            ),
          ),
          title: Text(
            "Notifiaction",
            style: TextStyle(
              //color: textColor,
              fontSize: 20,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
           actions: [
          GestureDetector(
            onTap: () {
             Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
                    builder: (context) => NotificationScreen(), maintainState: false));
    
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.notifications_rounded,
                size: 26,
               // color: iconsColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.grid_view_outlined,
                size: 26,
                //Scolor: iconsColor,
              ),
            ),
          ),
        ],
        ),
     
      backgroundColor: Theme.of(context).colorScheme.background,
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              getCurrentWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegment() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Theme.of(context).colorScheme.background,
        // color: Color(0xFFF5FFFF)
      )),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  tabID = 1;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                decoration: segmentDecoration(1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Notifications', style: segmentText(1)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
                onTap: () {
                  setState(() {
                    tabID = 2;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                  decoration: segmentDecoration(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Recommendations', style: segmentText(2)),
                    ],
                  ),
                )),
          ),
          
        ],
      ),
    );
  }

  segmentText(val) {
    return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: tabID == val ? Color(0xFF0090B7) : Color(0xFF818182));
  }

  segmentDecoration(val) {
    BorderRadiusGeometry? borderRadius2;

    if (val == 1) {
      borderRadius2 = const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4));
    } else if (val == 2) {
      borderRadius2 = const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4));
    } else if (val == 3) {
      borderRadius2 = const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4));
    } else {
      borderRadius2 = const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4));
    }
    return BoxDecoration(
      border: Border.all(
          color: tabID == val ? Color(0xFFDEE2E6) : Color(0xFFF5FFFF)),
      color: tabID == val ? Color(0xFFF5FFFF) : Color(0xFFF5FFFF),
      borderRadius: borderRadius2,
    );
  }

 _buildNotificationsBodySwitch() {
    if (tabID == 1) {
      return Column(
        children: [
          //NotificationsFilter(),
          Container(
           height: MediaQuery.of(context).size.height,
              
           child: Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          NotificationsFilter(),
          Divider(color: greyColor),
           SizedBox(
            height: 8.0,
          ),
         
          
        ],
      ),
    )
              ),
          SizedBox(
            height: 20,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Center(
            child: Column(
              children: [
            
               Container(
                
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(
                              height: 20,
                            ),
                    
                         Image.asset(
                        'assets/images/landing/rec_img.png',
                       ),
                      Container(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top :20.0, left: 40),
                              child: Text(
                                "Healthy steps",
                                style: TextStyle(fontWeight: FontWeight.w500),
                                //style: CustomTextStyles.titleLargeGray900,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left : 40, top: 8),
                              // padding: getPadding(
                              //   top: 3,
                              // ),
                              child: Text(
                                "02/08/2022",
                                //style: CustomTextStyles.bodyMediumGray600,
                              ),
                            ),
                            HealthTipsCarousel(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 45, top: 20),
                      
                        child: Row(
                          children: [
                            Icon(Icons.bookmarks_outlined,
                          
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.send_outlined,
                          
                            ),
                            
                            
                          ],
                        ),
                      ),
                      ]
            ))],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );
    }
  }


  

}
