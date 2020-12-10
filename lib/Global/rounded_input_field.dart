import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/Global/text_field_container.dart';
import 'package:my_rkm_hikai/Resources/colors.dart';


class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator formFieldValidator;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.formFieldValidator,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller:controller,
        onChanged: onChanged,
        cursorColor: PrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: PrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        validator:formFieldValidator
      ),
    );
  }
}