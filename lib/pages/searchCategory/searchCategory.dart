import 'package:MovieStar/env/enviroment.dart';
import 'package:MovieStar/services/search.dart';
import 'package:MovieStar/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchCategory extends StatefulWidget {
  final itemSearch;
  SearchCategory({this.itemSearch});
  @override
  _SearchCategoryState createState() => _SearchCategoryState(itemSearch);
}

class _SearchCategoryState extends State<SearchCategory> {
  var searchData = [];
  var itemSearch;
  _SearchCategoryState(this.itemSearch);
  final searchProvider = new SearchService();
  var photo = NetworkImage(DEFAULT_IMAGE_NETWORK);
  @override
  void initState() {
    searchProvider
        .searchByCategory(genre_id: itemSearch)
        .then((response) => {
              if (response.statusCode == 200 || response.statusCode == 201)
                {
                  setState(() {
                    searchData = response.data["results"];
                  })
                }
            })
        .catchError((error) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.only(top: 0.0),
        itemCount: searchData.length,
        itemBuilder: (ctx, i) {
          return card(searchData[i], context);
        },
      ),
    );
  }

  Widget card(var item, BuildContext context) {
    bool noImage = false;
    if (item['backdrop_path'] == null) {
      noImage = true;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 20.0, bottom: 0.0),
      child: InkWell(
        onTap: () async {
          Navigator.pushNamed(context, '/movieSliderDetail',
              arguments: {"movie": item});
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "hero-tag-list-${item['id']}",
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: const Color(0xFF000000),
                child: Container(
                  height: 95.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      image: noImage
                          ? null
                          : DecorationImage(
                              image: NetworkImage(
                                "${IMAGE_URL + item['backdrop_path']}",
                              ),
                              fit: BoxFit.cover)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Container(
                        width: 180.0,
                        child: Text(
                          item["title"],
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 15.0,
                          color: Colors.white54,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Text(
                              formatYear(item["release_date"]),
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white54, fontFamily: "Gotik"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
