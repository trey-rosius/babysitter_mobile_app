import 'package:flutter/material.dart';




class ThemeColor {
  static const Color primaryColor = Color(0xFFfcce01);
  static const Color secondaryColor =  Color(0XFFd6ecff);
  static const Color tertiaryColor =  Color(0XFFcffddb);
  static const Color color1 = Color(0xFFffb59e);
  static const Color color2 = Color(0xFFfee240);
  static const Color black = Color(0xFF000000);
  static const Color textfieldColor = Color(0xFF2b2b2b);
  static const Color greyColor = Color(0xFF161616);
  static const Color chatBoxOther = Color(0xFF3d3d3f);
  static const Color secondary = Color(0xFFf94c84);

  static const Color cardBackground = Color(0xFFcffedb);


  static Shader linearGradient = const LinearGradient(
    colors: <Color>[secondary, primaryColor],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  static Shader linearGradient2 = const LinearGradient(
    colors: <Color>[color1, color2],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}