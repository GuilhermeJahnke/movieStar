import 'dart:async';

import 'package:MovieStar/components/movieCard/movieCard.dart';
import 'package:MovieStar/env/enviroment.dart';
import 'package:MovieStar/pages/category/category.dart';
import 'package:MovieStar/pages/home/home.dart';
import 'package:MovieStar/services/movie.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:MovieStar/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

class CardDescription extends StatefulWidget {
  final data;
  CardDescription({this.data});

  @override
  _CardDescriptionState createState() => _CardDescriptionState();
}

@override
class _CardDescriptionState extends State<CardDescription> {
  var similarMovie;
  var category;
  var reviewMovie = [];
  bool loadingSimilar = true;
  bool loadingCategory = true;
  bool reviewSimilar = true;

  final MovieProvider = new MovieService();

  @override
  void initState() {
    MovieProvider.getSimilar(movieId: widget.data["id"]).then((response) => {
          if (response.statusCode == 200 || response.statusCode == 201)
            {
              setState(() {
                formatCategoryRelational(response.data["results"]);
              }),
            }
        });
    MovieProvider.getReviews(movieId: widget.data["id"]).then((response) => {
          if (response.statusCode == 200 || response.statusCode == 201)
            {
              setState(() {
                reviewMovie = response.data["results"];
                reviewSimilar = false;
              }),
            }
        });
    formatCategoryMovie();
    super.initState();
  }

  Future<void> formatCategoryRelational(response) async {
    var formated = await formatCategory(response);
    setState(() {
      similarMovie = formated;
      loadingSimilar = false;
    });
  }

  Future<void> formatCategoryMovie() async {
    var formated = await formatCategoryObject(widget.data);
    setState(() {
      category = formated;
      loadingCategory = false;
    });
  }

  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    var image = "${IMAGE_URL + widget.data['backdrop_path']}";
    var title = widget.data["title"];
    var description = widget.data["overview"];
    var vote_count = widget.data["vote_count"];
    var popularity = widget.data["popularity"];

    var _icon = Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          height: 50.0,
          child: loadingCategory
              ? SizedBox()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.4,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (ctx, index) {
                    return KeywordItem(
                      category["genre_name"][index],
                    );
                  },
                  itemCount: category["genre_name"].length,
                ),
        ),
      ],
    );
    var identifier = Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 25,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w700),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(child: LikeButton())
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${getShortForm(vote_count).toString()} curtidas",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${getShortForm(popularity).toString()} Views",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    var _desc = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: Text(
            "Sobre",
            style: TextStyle(
                fontFamily: "Sofia",
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 20.0, right: 20.0, bottom: 50.0),
          child: Text(
            description,
            style: TextStyle(
                fontFamily: "Sofia",
                color: Colors.white54,
                fontSize: 16.0,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
    var _ratting = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            width: 600.0,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Comentários",
                    style: TextStyle(
                        fontFamily: "Sofia",
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(top: 0.0),
                    itemCount: !reviewSimilar && reviewMovie.length > 10
                        ? 10
                        : reviewMovie.length,
                    itemBuilder: (ctx, i) {
                      return reviewSimilar
                          ? cardLoading()
                          : _buildRating(item: reviewMovie[i]);
                    },
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20.0)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
    var _relatedPostVar = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Text(
            "Filmes Relacionados",
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        loadingSimilar
            ? Container(child: cardLoading())
            : dataLoadedList(context, similarMovie),
        SizedBox(
          height: 40.0,
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: ThemeStyle.baseColor,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                expandedHeight: _height - 300,
                img: image,
                title: title,
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  identifier,
                  _icon,
                  _desc,
                  _ratting,
                  _relatedPostVar,
                ])),
          ],
        ),
      ),
    );
  }
}

getShortForm(var number) {
  var f = NumberFormat.compact(locale: "pt_BR");
  return f.format(number);
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String img, title;

  MySliverAppBar({@required this.expandedHeight, this.img, this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      fit: StackFit.expand,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: ThemeStyle.baseColor,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w700,
              fontSize: (expandedHeight / 40) - (shrinkOffset / 40) + 18,
            ),
          ),
        ),
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: new DecoratedBox(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(img),
              ),
              shape: BoxShape.rectangle,
            ),
            child: Container(
              margin: EdgeInsets.only(top: 130.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(0.0, 1.2),
                  stops: [0.0, 1.0],
                  colors: <Color>[
                    Color(0x000f0e1c),
                    Color(0xFF000000),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            color: Colors.black87.withOpacity(0.8),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                    ))),
            SizedBox(
              width: 36.0,
            )
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

Widget _buildRating({item}) {
  var date = item["updated_at"];
  var details = item["content"];
  var image = IMAGE_URL + item["author_details"]['avatar_path'];
  return Column(
    children: [
      ListTile(
        leading: Container(
          height: 45.0,
          width: 45.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 10),
          child: Text(
            formatDate(date),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
        subtitle: Text(
          details,
          maxLines: 10,
          style: TextStyle(
              fontFamily: "Sofia",
              color: Colors.white,
              fontWeight: FontWeight.w300),
        ),
      ),
    ],
  );
}
