import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? textlabel;
  final String hinttext;
  final bool? isCollapsed;
  final bool? filled;
  final Widget prefixicon;
  final Color? colorfill;
  final bool? readOnly;
  final bool? obscureText;
  final TextInputType? typekeybord;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final void Function()? showtext;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final void Function()? onTap;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.textlabel,
    required this.hinttext,
    this.isCollapsed,
    this.suffix,
    this.filled,
    required this.prefixicon,
    this.colorfill,
    this.readOnly,
    this.obscureText,
    this.typekeybord,
    this.validator,
    this.onTap,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.showtext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: textlabel,
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.black),
        isCollapsed: isCollapsed ?? false,
        prefixIcon: GestureDetector(onTap: showtext, child: prefixicon),
        suffixIcon: suffix,
        filled: filled ?? true,
        fillColor: colorfill ?? Colors.white,
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.brown.shade500),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.brown.shade800, width: 1),
            ),
        disabledBorder:
            disabledBorder ??
            OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      keyboardType: typekeybord ?? .text,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      validator: validator,
      onTap: onTap,
    );
  }
}
