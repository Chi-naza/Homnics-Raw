import 'package:flutter/material.dart';

import '../../../common/utils/colors.dart';
import '../models/symptoms.dart';

class SymptomItem extends StatefulWidget {
  Symptom symptom;
  bool isSelected;
  SymptomItem({required this.symptom, required this.isSelected, Key? key})
      : super(key: key);

  @override
  State<SymptomItem> createState() => _SymptomItemState();
}

class _SymptomItemState extends State<SymptomItem> {
  @override
  void initState() {
    print(widget.isSelected);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 33,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: widget.isSelected ? Colors.greenAccent : Colors.transparent,
        border: Border.all(
          color: secondaryFillColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            widget.symptom.description,
            style: TextStyle(
                color: secondaryFillColor,
                fontSize: 13,
                fontFamily: 'RedHatDisplay',
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
