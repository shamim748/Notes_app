import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final Alignment alignment;
  final bool underline;
  final Color? backgroundColor;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = Alignment.center,
    this.underline = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style:
              textStyle ??
              TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
                decoration: underline ? TextDecoration.underline : null,
              ),
        ),
      ),
    );
  }
}
