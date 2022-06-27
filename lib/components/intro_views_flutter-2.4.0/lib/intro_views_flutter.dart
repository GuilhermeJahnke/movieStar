library intro_views_flutter;

import 'dart:async';

import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Animation_Gesture/animated_page_dragger.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Animation_Gesture/page_dragger.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Animation_Gesture/page_reveal.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Constants/constants.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/pager_indicator_view_model.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/slide_update_model.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/UI/page.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/UI/page_indicator_buttons.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/UI/pager_indicator.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:flutter/material.dart';

class IntroViewsFlutter extends StatefulWidget {
  final List<PageViewModel> pages;
  final VoidCallback onTapDoneButton;
  final Color pageButtonsColor;
  final bool showSkipButton;
  final TextStyle pageButtonTextStyles;
  final VoidCallback onTapSkipButton;
  final double pageButtonTextSize;
  final String pageButtonFontFamily;
  final Widget doneText;
  final Widget skipText;
  final bool doneButtonPersist;
  final MainAxisAlignment columnMainAxisAlignment;
  final double fullTransition;

  IntroViewsFlutter(
    this.pages, {
    Key key,
    this.onTapDoneButton,
    this.showSkipButton = true,
    this.pageButtonTextStyles,
    this.pageButtonTextSize = 18.0,
    this.pageButtonFontFamily,
    this.onTapSkipButton,
    this.pageButtonsColor,
    this.doneText = const Text("DONE"),
    this.skipText = const Text("SKIP"),
    this.doneButtonPersist = false,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
    this.fullTransition = FULL_TARNSITION_PX,
  }) : super(key: key);

  @override
  _IntroViewsFlutterState createState() => _IntroViewsFlutterState();
}

class _IntroViewsFlutterState extends State<IntroViewsFlutter>
    with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;

  AnimatedPageDragger animatedPageDragger;
  int activePageIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  StreamSubscription<SlideUpdate> slideUpdateStream$;

  @override
  void initState() {
    slideUpdateStream = StreamController<SlideUpdate>();
    slideUpdateStream$ = slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activePageIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activePageIndex + 1;
          } else {
            nextPageIndex = activePageIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            nextPageIndex = activePageIndex;
          }
          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activePageIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    slideUpdateStream$?.cancel();
    animatedPageDragger?.dispose();
    slideUpdateStream?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
            fontSize: widget.pageButtonTextSize ?? 18.0,
            color: widget.pageButtonsColor ?? ThemeStyle.baseInputColor,
            fontFamily: widget.pageButtonFontFamily)
        .merge(widget.pageButtonTextStyles);

    List<PageViewModel> pages = widget.pages;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          PageIntro(
            pageViewModel: pages[activePageIndex],
            percentVisible: 1.0,
            columnMainAxisAlignment: widget.columnMainAxisAlignment,
          ),
          PageReveal(
            revealPercent: slidePercent,
            child: PageIntro(
                pageViewModel: pages[nextPageIndex],
                percentVisible: slidePercent,
                columnMainAxisAlignment: widget.columnMainAxisAlignment),
          ),
          PagerIndicator(
            viewModel: PagerIndicatorViewModel(
              pages,
              activePageIndex,
              slideDirection,
              slidePercent,
            ),
          ),
          PageIndicatorButtons(
            textStyle: textStyle,
            acitvePageIndex: activePageIndex,
            totalPages: pages.length,
            onPressedDoneButton: widget.onTapDoneButton,
            slidePercent: slidePercent,
            slideDirection: slideDirection,
            onPressedSkipButton: () {
              setState(() {
                activePageIndex = pages.length - 1;
                nextPageIndex = activePageIndex;
                if (widget.onTapSkipButton != null) {
                  widget.onTapSkipButton();
                }
              });
            },
            showSkipButton: widget.showSkipButton,
            doneText: widget.doneText,
            skipText: widget.skipText,
            doneButtonPersist: widget.doneButtonPersist,
          ),
          PageDragger(
            fullTransitionPX: widget.fullTransition,
            canDragLeftToRight: activePageIndex > 0,
            canDragRightToLeft: activePageIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          ),
        ],
      ),
    );
  }
}
