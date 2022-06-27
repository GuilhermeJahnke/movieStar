import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:flutter/material.dart';

class PageIntro extends StatelessWidget {
  final PageViewModel pageViewModel;
  final double percentVisible;
  final MainAxisAlignment columnMainAxisAlignment;
  PageIntro({
    this.pageViewModel,
    this.percentVisible = 1.0,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      color: pageViewModel.pageColor,
      child: new Opacity(
        opacity: percentVisible,
        child: new OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitPage()
              : __buildLandscapePage();
        }),
      ),
    );
  }

  Widget _buildPortraitPage() {
    return new Column(
      mainAxisAlignment: columnMainAxisAlignment,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: new _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ),
        Flexible(
          flex: 1,
          child: new _TitlePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ),
        Flexible(
          flex: 2,
          child: new _BodyPageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ),
      ],
    );
  }

  Widget __buildLandscapePage() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: new _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ),
        new Flexible(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new _TitlePageTransform(
                percentVisible: percentVisible,
                pageViewModel: pageViewModel,
              ),
              new _BodyPageTransform(
                percentVisible: percentVisible,
                pageViewModel: pageViewModel,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BodyPageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;

  const _BodyPageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      transform:
          new Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: new Padding(
        padding: const EdgeInsets.only(
          bottom: 120.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel.bodyTextStyle,
          textAlign: TextAlign.center,
          child: pageViewModel.body,
        ),
      ),
    );
  }
}

class _ImagePageTransform extends StatelessWidget {
  final double percentVisible;
  final PageViewModel pageViewModel;
  const _ImagePageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      transform:
          new Matrix4.translationValues(0.0, 50.0 * (1 - percentVisible), 0.0),
      child: new Padding(
        padding: new EdgeInsets.only(
          top: 60.0,
          bottom: 0.0,
        ),
        child: new Container(
          width: double.infinity,
          child: pageViewModel.mainImage,
        ),
      ),
    );
  }
}

class _TitlePageTransform extends StatelessWidget {
  final double percentVisible;
  final PageViewModel pageViewModel;
  const _TitlePageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      transform:
          new Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: new Padding(
        padding: new EdgeInsets.only(
          bottom: 0.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel.titleTextStyle,
          child: pageViewModel.title,
        ),
      ),
    );
  }
}
