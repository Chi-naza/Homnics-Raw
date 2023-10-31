import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homnics/common/utils/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Increment Decrement Demo';
    return MaterialApp(
      title: title,
      home: NumberInputWithIncrementDecrement(),
    );
  }
}

class NumberInputWithIncrementDecrement extends StatefulWidget {
  @override
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  TextEditingController _controller = TextEditingController();

  int min = 0;

  List<TextInputFormatter> _digitFormatters() {
    return <TextInputFormatter>[
      min.isNegative
          ? FilteringTextInputFormatter.allow(
              RegExp(r'[\-]?\d*'),
              replacementString: _controller.text,
            )
          : FilteringTextInputFormatter.digitsOnly
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller.text = "0"; // Setting the initial value for the field.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Color(0xFFE6E9EF),
          width: 2.0,
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextFormField(
              showCursor: false,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(color: Colors.white)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(color: Colors.white)),
                hoverColor: Colors.white,
                contentPadding: EdgeInsets.all(8.0),
                focusColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(color: Colors.white)),
              ),
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
                signed: true,
              ),
              inputFormatters: _digitFormatters(),
            ),
          ),
          Container(
            height: 50.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.arrow_drop_up,
                    color: primaryColor,
                    size: 24.0,
                  ),
                  onTap: () {
                    int currentValue = int.parse(_controller.text);
                    setState(() {
                      currentValue++;
                      _controller.text =
                          (currentValue).toString(); // incrementing value
                    });
                  },
                ),
                InkWell(
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: int.parse(_controller.text) == 0
                        ? greyColor
                        : primaryColor,
                    size: 24.0,
                  ),
                  onTap: int.parse(_controller.text) == 0
                      ? null
                      : () {
                          int currentValue = int.parse(_controller.text);
                          setState(() {
                            print("Setting state");
                            currentValue--;
                            _controller.text =
                                (currentValue > 0 ? currentValue : 0)
                                    .toString(); // decrementing value
                          });
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
