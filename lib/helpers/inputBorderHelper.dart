import 'package:flutter/material.dart';

//метод для создания рамки для ввода
OutlineInputBorder inputBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color),
  );
}
