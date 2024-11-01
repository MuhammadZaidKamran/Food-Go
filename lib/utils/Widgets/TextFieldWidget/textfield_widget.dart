import 'package:flutter/material.dart';

Widget textField(String name, int lines, TextEditingController itemController) {
  return TextField(
    controller: itemController,
    maxLines: lines,
    decoration: InputDecoration(
        hintText: name,
        filled: true,
        fillColor: const Color.fromARGB(48, 158, 158, 158),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12))),
  );
}
