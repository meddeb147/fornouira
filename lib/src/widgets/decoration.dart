import 'package:flutter/material.dart';

class DecorationInputTxt {
  String hint = '';
  double Border = 20;
  Icon icon = Icon(Icons.person);
  InputDecoration deco(Icon, String hint, double border) {
    this.Border = border;
    this.hint = hint;
    this.icon = Icon;
    return InputDecoration(
      prefixIcon: Icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(border),
        ),
      ),
      hintText: hint,
    );
  }
}
