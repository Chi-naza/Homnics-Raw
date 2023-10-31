import 'package:flutter/material.dart';
import 'package:homnics/features/appointment/widgets/cubicle.dart';

import '../../../common/utils/colors.dart';
import '../../professionals/models/professionals.dart';
import '../screens/appointment_details_screen.dart';

class ProfessionalWidget extends StatelessWidget {
  Professional professional;
  ProfessionalWidget({required this.professional, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("PROFESSIONAL DETAILS : ${professional.bio}");
    print("PROFESSIONAL NAME : ${professional.email}");
    return Column(
      children: [
        Card(
          //color: Colors.white,
          elevation: 0,
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("${professional.avatar}"),
              ),
            ),
            //Icon(Icons.star),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${professional.specialties}',
                  style: TextStyle(
                      fontSize: 14,
                      color: greyColor,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  '${professional.name}',
                  style: TextStyle(
                      fontSize: 16,
                      //color: textColor,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available On:  ",
                      ),
                      Expanded(
                        child: Container(
                          height: 20,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: professional.getAvailability.length,
                              itemBuilder: (context, index) {
                                String available =
                                    professional.getAvailability[index];
                                return Cubicle(item: available);
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            subtitle: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Speaks:  ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(
                      height: 20,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: professional.getLanguages.length,
                          itemBuilder: (context, index) {
                            String language = professional.getLanguages[index];
                            return Cubicle(item: language);
                          }),
                    ),
                  ),
                ],
              ),
            ),

            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppointmentDetailsScreen(
                          professional: professional,
                        ))),
          ),
        ),
        Divider()
      ],
    );
  }
}
