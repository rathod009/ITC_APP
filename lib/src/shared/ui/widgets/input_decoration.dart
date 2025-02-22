// widgets/input_decoration.dart
import 'package:flutter/material.dart';
import 'outline_input_border.dart'; // Import the outline border

InputDecoration inputDecoration(String labelText, String hintText) {
  return InputDecoration(
    disabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    enabledBorder: outlineInputBorder(),
    labelText: labelText,
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 16,
      color: Color(0xff9e9e9e),
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 14,
      color: Color(0xff9e9e9e),
    ),
    filled: true,
    fillColor: const Color(0x00f2f2f3),
    isDense: false,
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  );
}