import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Constants/constants.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/page_bubble_view_model.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/pager_indicator_view_model.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/UI/page_bubble.dart';
import 'package:flutter/material.dart';

class PagerIndicator extends StatelessWidget {
  final PagerIndicatorViewModel viewModel;
  PagerIndicator({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];

    for (var i = 0; i < viewModel.pages.length; i++) {
      final page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(PageBubble(
        viewModel: PageBubbleViewModel(
          iconAssetPath: page.iconImageAssetPath,
          iconColor: page.iconColor,
          isHollow: isHollow,
          activePercent: percentActive,
          bubbleBackgroundColor: page.bubbleBackgroundColor,
          bubbleInner: page.bubble,
        ),
      ));
    }

    final baseTranslation =
        ((viewModel.pages.length * BUBBLE_WIDTH) / 2) - (BUBBLE_WIDTH / 2);
    var translation = baseTranslation - (viewModel.activeIndex * BUBBLE_WIDTH);

    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += BUBBLE_WIDTH * viewModel.slidePercent;
    } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }
    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.translationValues(translation, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bubbles,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
