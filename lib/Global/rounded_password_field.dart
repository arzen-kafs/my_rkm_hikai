import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/Global/text_field_container.dart';
import 'package:my_rkm_hikai/Resources/colors.dart';

// ignore: must_be_immutable
class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  final TextEditingController controller;
  bool password_visible =false;
   RoundedPasswordField({
    Key key,
    this.password_visible,
    this.hintText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: widget.password_visible,//This will obscure text dynamically
        controller: widget.controller,
        onChanged: widget.onChanged,

        cursorColor: PrimaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: PrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
                  widget.password_visible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: PrimaryColor,
            ),
            onPressed: (){
              setState(() {
                if(widget.password_visible==true)
                  widget.password_visible=false;
                else
                  widget.password_visible=true;
              });
            },
          ),
          border: InputBorder.none,

        ),
      ),
    );
  }
}