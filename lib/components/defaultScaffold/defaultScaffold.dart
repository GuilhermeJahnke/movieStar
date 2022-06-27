import 'package:MovieStar/components/defaultAppBar/defaultAppBar.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  DefaultScaffold(
      {this.child, this.returnPage = true, this.menuSlider = true, this.title});

  final Widget child;
  final bool returnPage;
  final bool menuSlider;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: title),
      backgroundColor: ThemeStyle.baseColor,
      body: child,
    );
  }
}
