import 'package:MovieStar/env/enviroment.dart';
import 'package:MovieStar/services/search.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:MovieStar/utils/utils.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final itemSearch;
  Search({this.itemSearch});
  @override
  _SearchState createState() => _SearchState(itemSearch);
}

class _SearchState extends State<Search> {
  var searchData = [];
  var itemSearch;
  _SearchState(this.itemSearch);
  final searchProvider = new SearchService();
  final _searchController = TextEditingController();
  var photo = NetworkImage(DEFAULT_IMAGE_NETWORK);
  @override
  void initState() {
    if (itemSearch != null && itemSearch != "") {
      searchProvider
          .searchMovie(query: itemSearch)
          .then((response) => {
                if (response.statusCode == 200 || response.statusCode == 201)
                  {
                    setState(() {
                      searchData = response.data["results"];
                    })
                  }
              })
          .catchError((error) {});
      _searchController.text = itemSearch;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 10.0, left: 20.0),
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
                      "Bem Vindo!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Sofia",
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Encontre seu filme preferido!",
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
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: ThemeStyle.baseColorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15.0,
                        spreadRadius: 0.0)
                  ]),
              child: new TextFormField(
                  controller: _searchController,
                  autofocus: false,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w400),
                  onFieldSubmitted: (value) =>
                      {onSearch(_searchController.text)},
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.white38,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w400),
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    icon: IconButton(
                        onPressed: () {
                          onSearch(_searchController.text);
                        },
                        icon: Icon(Icons.search, color: Colors.white)),
                    focusedBorder: InputBorder.none,
                    hintText: 'Pesquisar',
                  )),
            ),
          ),
          searchData.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(top: 0.0),
                  itemCount: searchData.length,
                  itemBuilder: (ctx, i) {
                    return card(searchData[i], context);
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            "assets/noData/noData.png",
                            height: 120.0,
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Nenhum Filme Encontrado",
                        style: TextStyle(
                            color: Colors.white70,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0),
                      )
                    ])
        ],
      )),
    );
  }

  onSearch(text) async {
    searchProvider
        .searchMovie(query: text)
        .then((response) => {
              if (response.statusCode == 200 || response.statusCode == 201)
                {
                  setState(() {
                    searchData = response.data["results"];
                  })
                }
            })
        .catchError((error) {});
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
