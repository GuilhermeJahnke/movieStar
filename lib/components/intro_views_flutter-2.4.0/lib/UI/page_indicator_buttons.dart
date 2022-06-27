// ignore_for_file: deprecated_member_use

import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Constants/constants.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/page_button_view_model.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  final PageButtonViewModel pageButtonViewModel;
  final Widget child;
  SkipButton({
    this.onTap,
    this.pageButtonViewModel,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    double opacity = 1.0;
    final TextStyle style = DefaultTextStyle.of(context).style;
    if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 2 &&
        pageButtonViewModel.slideDirection == SlideDirection.rightToLeft) {
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    } else if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 1 &&
        pageButtonViewModel.slideDirection == SlideDirection.leftToRight) {
      opacity = pageButtonViewModel.slidePercent;
    }

    return FlatButton(
      onPressed: onTap,
      child: Opacity(
        opacity: opacity,
        child: DefaultTextStyle.merge(
          style: style,
          child: child,
        ),
      ),
    );
  }
}

class DoneButton extends StatelessWidget {
  final VoidCallback onTap;
  final PageButtonViewModel pageButtonViewModel;
  final Widget child;
  DoneButton({
    this.onTap,
    this.pageButtonViewModel,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    double opacity = 1.0;
    final TextStyle style = DefaultTextStyle.of(context).style;
    if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 1 &&
        pageButtonViewModel.slideDirection == SlideDirection.leftToRight) {
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    }

    return FlatButton(
      onPressed: onTap,
      child: Opacity(
        opacity: opacity,
        child: DefaultTextStyle.merge(
          style: style,
          child: child,
        ),
      ),
    );
  }
}

class PageIndicatorButtons extends StatelessWidget {
  final int acitvePageIndex;
  final int totalPages;
  final VoidCallback onPressedDoneButton;
  final VoidCallback onPressedSkipButton;
  final SlideDirection slideDirection;
  final double slidePercent;
  final bool showSkipButton;

  final Widget doneText;
  final Widget skipText;
  final TextStyle textStyle;

  final bool doneButtonPersist;

  PageIndicatorButtons({
    @required this.acitvePageIndex,
    @required this.totalPages,
    this.onPressedDoneButton,
    this.slideDirection,
    this.slidePercent,
    this.onPressedSkipButton,
    this.showSkipButton = true,
    this.skipText,
    this.doneText,
    this.textStyle,
    this.doneButtonPersist,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: DefaultTextStyle(
        style: textStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ((acitvePageIndex < totalPages - 1 ||
                          (acitvePageIndex == totalPages - 1 &&
                              slideDirection == SlideDirection.leftToRight)) &&
                      showSkipButton)
                  ? SkipButton(
                      child: skipText,
                      onTap: onPressedSkipButton,
                      pageButtonViewModel: PageButtonViewModel(
                        activePageIndex: acitvePageIndex,
                        totalPages: totalPages,
                        slidePercent: slidePercent,
                        slideDirection: slideDirection,
                      ),
                    )
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: (acitvePageIndex == totalPages - 1 ||
                      (acitvePageIndex == totalPages - 2 &&
                              slideDirection == SlideDirection.rightToLeft ||
                          doneButtonPersist))
                  ? DoneButton(
                      child: doneText,
                      onTap: onPressedDoneButton,
                      pageButtonViewModel: PageButtonViewModel(
                        activePageIndex: acitvePageIndex,
                        totalPages: totalPages,
                        slidePercent: doneButtonPersist ? 0.0 : slidePercent,
                        slideDirection: slideDirection,
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
