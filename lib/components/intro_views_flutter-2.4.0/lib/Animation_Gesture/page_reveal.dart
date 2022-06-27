import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Clipper/circular_reveal_clipper.dart';
import 'package:flutter/material.dart';

class PageReveal extends StatelessWidget {
  final double revealPercent;
  final Widget child;

  PageReveal({this.revealPercent, this.child});

  @override
  Widget build(BuildContext context) {
    return new ClipOval(
      clipper: new CircularRevealClipper(revealPercent: revealPercent),
      child: child,
    );
  }
}
