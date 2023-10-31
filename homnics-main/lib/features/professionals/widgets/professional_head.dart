import 'package:flutter/material.dart';
import 'package:homnics/features/professionals/models/professionals.dart';

import '../../../common/utils/colors.dart';

class ProfessionalHeader extends StatelessWidget {
  Professional professional;
  ProfessionalHeader({required this.professional, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage("${professional.avatar}"),
            backgroundColor: Colors.transparent,
            child: Stack(children: [
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white70,
                  child: Container(
                    height: 12,
                    width: 12,
                    child: Image.asset('assets/images/landing/is_active.png'),
                  ),
                ),
              ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            professional.name ?? '',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'RedHatDisplay',
              fontWeight: FontWeight.w500,
              //color: iconsColor
            ),
          ),
        ),
        Text(
          professional.getSpecialities,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'RedHatDisplay',
            fontWeight: FontWeight.w500,
            //color: greyColor
          ),
        ),
        Text(
          professional.title ?? "",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'RedHatDisplay',
            fontWeight: FontWeight.w500,
            //color: iconsColor
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Text(
              '(145)',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'RedHatDisplay',
                  fontWeight: FontWeight.w500,
                  color: greyColor),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Divider(height: 20, endIndent: 60, indent: 70, color: greyColor),
      ],
    );
  }
}
