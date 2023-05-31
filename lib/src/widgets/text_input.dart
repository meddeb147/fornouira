import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hint;
  final double border;
  final Icon? icon;

  const TextInput({
    super.key,
    this.hint = '',
    this.border = 20,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
    // TODO:
    /*
    InputDecoration(
      prefixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(border),
        ),
      ),
      hintText: hint,
    );
     */
  }
}
