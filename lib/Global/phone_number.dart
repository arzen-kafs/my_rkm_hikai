import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/Global/text_field_container.dart';
import 'package:my_rkm_hikai/Resources/colors.dart';

class PhoneNumber extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const PhoneNumber({
    Key key,
    this.hintText,
    this.icon = Icons.phone,
    this.onChanged,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: PrimaryColor,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: PrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}