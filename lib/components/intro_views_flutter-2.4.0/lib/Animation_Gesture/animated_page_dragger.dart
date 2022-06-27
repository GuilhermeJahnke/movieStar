import 'dart:async';
import 'dart:ui';

import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Constants/constants.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/slide_update_model.dart';
import 'package:flutter/material.dart';

class AnimatedPageDragger {
  final SlideDirection slideDirection;

  final TransitionGoal transitionGoal;

  AnimationController completionAnimationController;

  AnimatedPageDragger({
    this.slideDirection,
    this.transitionGoal,
    double slidePercent,
    StreamController<SlideUpdate> slideUpdateStream,
    TickerProvider vsync,
  }) {
    final startSlidePercent = slidePercent;
    double endSlidePercent;
    Duration duration;

    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;

      final slideRemaining = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    } else {
      endSlidePercent = 0.0;

      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }

    completionAnimationController = AnimationController(
        duration: duration, vsync: vsync)
      ..addListener(() {
        final slidePercent = lerpDouble(startSlidePercent, endSlidePercent,
            completionAnimationController.value);

        slideUpdateStream.add(
            SlideUpdate(slideDirection, slidePercent, UpdateType.animating));
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          slideUpdateStream.add(SlideUpdate(
              slideDirection, slidePercent, UpdateType.doneAnimating));
        }
      });
  }

  void run() {
    completionAnimationController.forward(from: 0.0);
  }

  void dispose() {
    completionAnimationController.dispose();
  }
}
