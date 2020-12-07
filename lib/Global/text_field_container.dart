import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/Resources/colors.dart';


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0.01),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: PrimaryLightColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}