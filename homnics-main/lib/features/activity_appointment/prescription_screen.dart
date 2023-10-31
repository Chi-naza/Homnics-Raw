import 'package:flutter/material.dart';
import 'package:homnics/common/utils/colors.dart';

class PrescribtionScreen extends StatefulWidget {
  final bool isIndividual;
  final String plan;
  const PrescribtionScreen(
      {super.key, required this.isIndividual, required this.plan});

  @override
  State<PrescribtionScreen> createState() => _PrescribtionScreenState();
}

class _PrescribtionScreenState extends State<PrescribtionScreen> {
  int tabID = 1;
  bool isSwitch = true;
  String dropdownValue = 'Appointments';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: CircleAvatar(
            backgroundColor: appBarColor,
            child: Image.asset(
              'assets/images/landing/img.png',
            ),
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Homnics",
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              color: iconsColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.grid_view_outlined,
              color: iconsColor,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropdownValue,
                elevation: 1,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: primaryColor,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                  if (newValue == 'Appointments') {
                    // navigate to the home screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => PrescribtionScreen()),
                    // );
                  } else if (newValue == 'Prescriptions') {
                    // navigate to the settings screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => PrescriptionsScreen()),
                    // );
                  }
                },
                items: <String>['Appointments', 'Prescriptions']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            isSwitch ? _buildSegment() : Container(),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, bottom: 8.0, right: 2),
                      child: Column(
                        children: [
                          // Container(
                          //   child: _buildBodySwitch(),
                          // ),
                          // Container(
                          //   child: _buildBodySwitch(),
                          // ),
                          // Container(
                          //   child: _buildBodySwitch(),
                          // ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegment() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFF5FFFF))),
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
                    Text('Scheduled', style: segmentText(1)),
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
                      Text('Pending', style: segmentText(2)),
                    ],
                  ),
                )),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  tabID = 3;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                decoration: segmentDecoration(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Declined', style: segmentText(3)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  tabID = 4;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                decoration: segmentDecoration(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Completed', style: segmentText(4)),
                  ],
                ),
              ),
            ),
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

  
}
