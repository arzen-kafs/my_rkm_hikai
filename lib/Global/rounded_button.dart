import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/Resources/colors.dart';



class RoundedButton extends StatefulWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = PrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}
int _state;
class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child:
        // FlatButton(
        //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        //   color: widget.color,
        //   onPressed: widget.press,
        //   child: Text(
        //     widget.text,
        //     style: TextStyle(color: widget.textColor),
        //   ),
        // ),
        MaterialButton(
            child: setUpButtonChild(),
            onPressed: widget.press,
            //     () {
            //   setState(() {
            //     if (_state == 0) {
            //       animateButton();
            //     }
            //   });
            // },
            elevation: 4.0,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            height: 48.0,
            color: widget.color
        ),
      ),
    );
  }
  Widget setUpButtonChild() {
    if (_state == 0) {
      return  Text(
        widget.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else   {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    };
    // else {
    //   return   Text(
    //     "Click Here",
    //     style: const TextStyle(
    //       color: Colors.white,
    //       fontSize: 16.0,
    //     ),
    //   );
    // }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 0;
      });
    });
  }
}

