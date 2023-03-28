import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.label,
      this.fontSize = 18,
      this.color,
      this.dColor,
      this.fontWeight})
      : super(key: key);

  final String label;
  final double fontSize;
  final Color? color;
  final Color? dColor;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      // textAlign: TextAlign.justify,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
