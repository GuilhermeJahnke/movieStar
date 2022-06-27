import 'package:MovieStar/components/movieCard/movie_header_slider/page_transformer.dart';
import 'package:MovieStar/env/enviroment.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IntroPageItem extends StatelessWidget {
  IntroPageItem({
    @required this.item,
    @required this.pageVisibility,
  });

  final item;
  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  getShortForm(var number) {
    var f = NumberFormat.compact(locale: "pt_BR");
    return f.format(number);
  }

  _buildTextContainer(BuildContext context) {
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.timer,
            color: Colors.white,
          ),
          Text(
            item['release_date'],
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
            textAlign: TextAlign.center,
          ),
          Icon(
            Icons.recommend,
            color: Colors.white,
          ),
          Text(
            "${item['vote_average'].toString()} /10",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
            textAlign: TextAlign.center,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          Text(
            getShortForm(item['vote_count']).toString(),
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          item['title'],
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          titleText,
          SizedBox(
            height: 10,
          ),
          categoryText,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
          ],
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Hero(
          tag: "hero-tag-${item['id']}",
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: ThemeStyle.baseColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                image: DecorationImage(
                  image: NetworkImage("${IMAGE_URL + item['backdrop_path']}"),
                  fit: BoxFit.cover,
                  alignment: FractionalOffset(
                    0.5 + (pageVisibility.pagePosition / 3),
                    0.5,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                      const Color(0xFF000000),
                      const Color(0x00000000),
                    ],
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    Navigator.pushNamed(context, '/movieSliderDetail',
                        arguments: {"movie": item});
                  },
                  child: Stack(
                    children: <Widget>[
                      imageOverlayGradient,
                      _buildTextContainer(context),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
