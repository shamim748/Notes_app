import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const TitleText({
    super.key,
    required this.text,
    this.color,
    this.fontSize = 20,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color ?? Theme.of(context).textTheme.headlineSmall?.color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
