import 'package:MovieStar/components/baseLayout/baseLayout.dart';
import 'package:MovieStar/components/cardDescription/cardDescription.dart';
import 'package:MovieStar/components/defaultScaffold/defaultScaffold.dart';
import 'package:MovieStar/pages/category/category.dart';
import 'package:MovieStar/pages/search/search.dart';
import 'package:MovieStar/pages/searchCategory/searchCategory.dart';
import 'package:MovieStar/pages/tutorial/tutorial.dart';
import 'package:MovieStar/shared/router_manager.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  final firstVisit;
  final protectedData;
  AppWidget(this.firstVisit, this.protectedData);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieStar',
      theme: ThemeData(
          unselectedWidgetColor: Colors.white,
          textSelectionTheme:
              TextSelectionThemeData(selectionColor: Colors.white38)),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return tutorial();
                });
            break;
          case '/home':
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return baseLayout();
                });
            break;
          case '/category':
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return Category();
                });
            break;
          case '/search':
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  var itemSearch = (ModalRoute.of(context).settings.arguments
                      as Map)["itemSearch"];
                  return DefaultScaffold(
                    title: "Busca",
                    menuSlider: false,
                    returnPage: true,
                    child: Search(
                      itemSearch: itemSearch,
                    ),
                  );
                });
            break;
          case '/searchCategory':
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  var itemSearch = (ModalRoute.of(context).settings.arguments
                      as Map)["itemSearch"];
                  var title = (ModalRoute.of(context).settings.arguments
                      as Map)["title"];
                  return DefaultScaffold(
                    title: title,
                    menuSlider: false,
                    returnPage: true,
                    child: SearchCategory(
                      itemSearch: itemSearch,
                    ),
                  );
                });
            break;
          case '/movieSliderDetail':
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  var movie = (ModalRoute.of(context).settings.arguments
                      as Map)["movie"];
                  return CardDescription(
                    data: movie,
                  );
                });
            break;
          default:
            return null;
        }
      },
      navigatorKey: RouterManager.navigatorKey,
    );
  }
}
