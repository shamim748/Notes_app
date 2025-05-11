import 'package:flutter/material.dart';

// Widget textFormField(
//   context, {
//   required TextEditingController controller,
//   required String hintText,
//   required String? Function(String? value) validator,
//   TextInputType keyboardType = TextInputType.text,
//   double height = 70,
//   double width = double.infinity,
//   int? maxLength,
// }) {
//   return SizedBox(
//     height: height,
//     width: width,
//     child: TextFormField(
//       style: Theme.of(context).textTheme.bodySmall,
//       maxLength: maxLength,
//       keyboardType: keyboardType,
//       controller: controller,
//       validator: validator,
//       decoration: InputDecoration(
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           // borderSide: BorderSide(
//           //   color:
//           //       isDark
//           //           ? const Color.fromRGBO(163, 163, 163, 1)
//           //           : const Color.fromRGBO(100, 100, 100, 1),
//           // ),
//         ),
//         counterText: "",
//         constraints: const BoxConstraints(minHeight: 50),
//         hintText: hintText,
//         enabledBorder: OutlineInputBorder(
//           // borderSide: BorderSide(
//           //   width: 1,
//           //   color:
//           //       isDark
//           //           ? const Color.fromRGBO(36, 39, 48, 1)
//           //           : const Color.fromRGBO(226, 226, 226, 1),
//           // ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final double? width;
  final double? height;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry contentPadding;
  final Color borderColor;
  final double borderRadius;
  final Color? fillColor;
  final bool filled;

  const CustomTextFormField({
    super.key,
    this.width,
    this.height,
    this.labelText,
    this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.borderColor = Colors.grey,
    this.borderRadius = 12.0,
    this.fillColor,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding,
        filled: filled,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: field,
    );
  }
}
