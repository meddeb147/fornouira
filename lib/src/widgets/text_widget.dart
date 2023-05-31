import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double? size;
  final FontWeight? fontWeight;

  const TextWidget(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.size = 20,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          fontStyle: FontStyle.italic,
          color: color,
        ));
  }
}
