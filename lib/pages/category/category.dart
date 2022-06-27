import 'package:MovieStar/env/enviroment.dart';
import 'package:MovieStar/services/genre.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:MovieStar/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> with TickerProviderStateMixin {
  var categories;
  bool loadingCategories = true;
  var photo = NetworkImage(DEFAULT_IMAGE_NETWORK);
  @override
  void initState() {
    final GenreProvider = new GenreService();
    GenreProvider.getGenres().then((response) => {
          if (response.statusCode == 200 || response.statusCode == 201)
            {
              setState(() {
                categories = response.data["genres"];
                loadingCategories = false;
              }),
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CircularImage(
                    photo,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Categorias",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Sofia",
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Selecione uma categoria!",
                      style: TextStyle(
                        color: Colors.white54,
                        fontFamily: "Sofia",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(top: 0.0),
            itemCount: loadingCategories ? 3 : categories.length,
            itemBuilder: (ctx, i) {
              return loadingCategories
                  ? cardLoading()
                  : ItemCard(item: categories[i]);
            },
          ),
        ],
      )),
    );
  }
}

class cardLoading extends StatelessWidget {
  @override
  cardLoading();
  final color = Colors.black38;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 400.0,
        height: 100.0,
        decoration: BoxDecoration(
            color: ThemeStyle.baseColorWhite,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 3.0,
                  spreadRadius: 1.0)
            ]),
        child: Shimmer.fromColors(
          baseColor: color,
          highlightColor: Colors.white,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    height: 8.0,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final item;
  ItemCard({
    this.item,
  });
  @override
  Widget build(BuildContext context) {
    var title = item["name"];
    var id = item["id"];
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/searchCategory',
            arguments: {"itemSearch": id, "title": title});
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
        child: Container(
          height: 100.0,
          width: 400.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: ThemeStyle.baseColorWhite,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w800,
                        fontSize: 22.0,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
