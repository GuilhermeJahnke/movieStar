import 'package:MovieStar/theme/theme.dart';
import 'package:flutter/material.dart';

class MovieSliderDetail extends StatefulWidget {
  final item;

  MovieSliderDetail({Key key, this.item}) : super(key: key);

  _MovieSliderDetailState createState() => _MovieSliderDetailState(item);
}

class _MovieSliderDetailState extends State<MovieSliderDetail> {
  final item;
  _MovieSliderDetailState(this.item);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    ScrollController _controller =
        new ScrollController(initialScrollOffset: _height / 2.5);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _controller,
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                  expandedHeight: _height - 300.0,
                  img: "${item['image']['host']}${item['image']['name']}",
                  id: item['id'],
                  title: item['title'],
                  category: "Por ${item['author']}"),
              pinned: true,
            ),
            SliverToBoxAdapter(
                child: Container(
              color: ThemeStyle.baseColorWhite,
              child: Column(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                    child: Text("data")),
                SizedBox(
                  height: 50.0,
                )
              ]),
            )),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  String img, id, title, category;

  MySliverAppBar(
      {@required this.expandedHeight,
      this.img,
      this.id,
      this.title,
      this.category});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Hero(
              transitionOnUserGestures: true,
              tag: 'hero-tag-${id}',
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
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                      colors: <Color>[
                        const Color(0xFF000000),
                        const Color(0x00000000),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                    child: Container(
                      child: Text(
                        category,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.5,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w400),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Gotik",
                    fontWeight: FontWeight.w700,
                    fontSize: (expandedHeight / 40) - (shrinkOffset / 40) + 18,
                  ),
                ),
              ),
              SizedBox(
                width: 36.0,
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
