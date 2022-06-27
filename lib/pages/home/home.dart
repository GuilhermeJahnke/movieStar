import 'package:MovieStar/components/movieCard/movieCard.dart';
import 'package:MovieStar/env/enviroment.dart';
import 'package:MovieStar/services/genre.dart';
import 'package:MovieStar/services/movie.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:MovieStar/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  var moviesTop;
  var moviesPopular;
  var moviesUpComming;
  var categories;
  bool loadingTop = true;
  bool loadingLatest = true;
  bool loadingPopular = true;
  bool loadingUpComming = true;
  bool loadingCategories = true;
  var photo = NetworkImage(DEFAULT_IMAGE_NETWORK);
  @override
  void initState() {
    final MovieProvider = new MovieService();
    final GenreProvider = new GenreService();

    MovieProvider.getTop().then((response) => {
          if (response.statusCode == 200 || response.statusCode == 201)
            {
              setState(() {
                moviesTop = response.data["results"];
                loadingTop = false;
              }),
            }
        });
    MovieProvider.getPopular().then((response) => {
          if (response.statusCode == 200 || response.statusCode == 201)
            {
              setState(() {
                moviesPopular = response.data["results"];
                loadingPopular = false;
              }),
            }
        });
    MovieProvider.getUpComming().then((response) => {
          if (response.statusCode == 200 || response.statusCode == 201)
            {
              setState(() {
                moviesUpComming = response.data["results"];
                loadingUpComming = false;
              }),
            }
        });
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

  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, right: 10.0, left: 20.0),
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
                    onFieldSubmitted: (value) => {routerByPageSearch()},
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(context, 3,
                          errorText: "Mínimo 3 dígitos!")
                    ]),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Sofia",
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.white38,
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w400),
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      icon: IconButton(
                          onPressed: () {
                            routerByPageSearch();
                          },
                          icon: Icon(Icons.search, color: Colors.white)),
                      focusedBorder: InputBorder.none,
                      hintText: 'Pesquisar',
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Melhores Avaliados",
                style: ThemeStyle.fontDescriptionStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: loadingTop
                  ? Container(
                      height: 180,
                      width: 400,
                      child: cardHeaderLoadingHome(context))
                  : Container(
                      height: 200, child: dataLoadedHeader(context, moviesTop)),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Categorias",
                style: ThemeStyle.fontDescriptionStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              height: 50.0,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.4,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (ctx, index) {
                  return loadingCategories
                      ? shimmerCategory()
                      : KeywordItem(
                          categories[index],
                        );
                },
                itemCount: loadingCategories ? 6 : categories.length,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Filmes Populares",
                style: ThemeStyle.fontDescriptionStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: loadingPopular
                  ? Container(
                      height: 180,
                      width: 400,
                      child: cardHeaderLoadingHome(context))
                  : Container(
                      height: 200,
                      child: dataLoadedHeader(context, moviesPopular)),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Em Breve",
                style: ThemeStyle.fontDescriptionStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: loadingUpComming
                  ? Container(
                      height: 180,
                      width: 400,
                      child: cardHeaderLoadingHome(context))
                  : Container(
                      height: 200,
                      child: dataLoadedHeader(context, moviesUpComming)),
            ),
          ],
        ),
      ),
    );
  }

  routerByPageSearch() {
    Navigator.pushNamed(context, '/search',
        arguments: {"itemSearch": _searchController.text});
  }
}

Widget cardHeaderLoadingHome(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      height: 500.0,
      width: 275.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Color(0xFF2C3B4F),
      ),
      child: Shimmer.fromColors(
        baseColor: Color(0xFF3B4659),
        highlightColor: Color(0xFF606B78),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 17.0,
                width: 70.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 20.0,
                width: 150.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 20.0,
                width: 250.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 20.0,
                width: 150.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class KeywordItem extends StatelessWidget {
  final categorySelected;

  KeywordItem(this.categorySelected);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/searchCategory', arguments: {
          "itemSearch": categorySelected["id"],
          "title": categorySelected["name"]
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: ThemeStyle.baseColorWhite,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.5,
                spreadRadius: 1.0,
              )
            ],
          ),
          child: Center(
            child: Text(
              categorySelected["name"],
              style: TextStyle(
                color: Colors.white70,
                fontFamily: "Sans",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class shimmerCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: ThemeStyle.baseColorWhite,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                )
              ]),
          child: Shimmer.fromColors(
            baseColor: Colors.black38,
            highlightColor: Colors.white,
            child: Center(
              child: Container(
                height: 9.5,
                width: double.infinity,
                color: Colors.black12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
