import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {

  final String hint;
  final String label;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool isEnabled;
  final bool isPassword;
  final Widget suffixIcon;
  final Function onValidate;

  AppTextField({
    @required this.hint,
    @required this.label,
    @required this.inputType,
    @required this.controller,
    @required this.isEnabled,
    @required this.isPassword,
    this.suffixIcon,
    @required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: controller,
      keyboardType: inputType,
      validator: onValidate,
      obscureText: isPassword,
      style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.purple, fontSize: 20.0)),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        hintText: hint,
        hintStyle: GoogleFonts.lato(textStyle: TextStyle(color: Colors.purple, fontSize: 20.0)),
        labelText: label,
        filled: true,
        fillColor: Colors.orangeAccent.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.4))
        )
      ),
    );
  }
}
