// All custom styles must be added here
import 'package:flutter/material.dart';

/* Transparencia HEX
100% - FF
95% - F2
90% - E6
85% - D9
80% - CC
75% - BF
70% - B3
65% - A6
60% - 99
55% - 8C
50% - 80
45% - 73
40% - 66
35% - 59
30% - 4D
25% - 40
20% - 33
15% - 26
10% - 1A
5% - 0D
0% - 00
*/
abstract class ThemeStyle {
  static const baseColor = Color(0xff0f0e1c);
  static const baseColorWhite = Color(0xFF2C3B4F);
  static const baseInputColor = Color(0xFF278fee);
  static const TextStyle fontHeaderStyle = TextStyle(
      fontFamily: "Calibri",
      fontSize: 26.0,
      fontWeight: FontWeight.w800,
      color: Color(0xccffffff),
      letterSpacing: 1.5);

  static const TextStyle fontDescriptionStyle = TextStyle(
      fontFamily: "Calibri",
      fontSize: 15.0,
      color: Colors.white,
      fontWeight: FontWeight.w400);

  static const secondaryColor = Color(0xfff0c14d);
  static const TextStyle inputTextStyle = TextStyle(color: Colors.black);
  static const TextStyle inputTextStyleWhite = TextStyle(color: Colors.white54);
}
