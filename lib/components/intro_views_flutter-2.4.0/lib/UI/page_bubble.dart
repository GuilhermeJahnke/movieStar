import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/page_bubble_view_model.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:flutter/material.dart';

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 55.0,
      height: 65.0,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: new Center(
        child: new Padding(
          padding: const EdgeInsets.all(0.5),
          child: new Container(
            width: 60.0,
            height: 4.0,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              color: viewModel.isHollow
                  ? Colors.white24
                  : ThemeStyle.baseInputColor,
              border: new Border.all(
                color: viewModel.isHollow
                    ? viewModel.bubbleBackgroundColor.withAlpha(
                        (0xFF * (0.1 - viewModel.activePercent)).round())
                    : Colors.white10,
                width: 2.0,
              ),
            ),
            child: new Opacity(
              opacity: viewModel.activePercent,
              child: (viewModel.iconAssetPath != null &&
                      viewModel.iconAssetPath != "")
                  ? new Image.asset(
                      viewModel.iconAssetPath,
                      color: viewModel.iconColor,
                    )
                  : new Container(),
            ),
          ),
        ),
      ),
    );
  }
}
