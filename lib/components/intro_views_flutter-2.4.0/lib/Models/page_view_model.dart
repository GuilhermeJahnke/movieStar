import 'package:flutter/material.dart';

class PageViewModel {
  final Color pageColor;
  final String iconImageAssetPath;
  final Color iconColor;
  final Color bubbleBackgroundColor;
  final Widget title;
  final Widget body;
  final TextStyle textStyle;
  final Widget mainImage;
  final Widget bubble;

  PageViewModel(
      {this.pageColor,
      this.iconImageAssetPath,
      this.bubbleBackgroundColor = const Color(0x88FFFFFF),
      this.iconColor,
      @required this.title,
      @required this.body,
      @required this.mainImage,
      this.bubble,
      this.textStyle});

  TextStyle get titleTextStyle {
    return TextStyle(color: Colors.white, fontSize: 50.0).merge(this.textStyle);
  }

  TextStyle get bodyTextStyle {
    return TextStyle(color: Colors.white, fontSize: 24.0).merge(this.textStyle);
  }
}
