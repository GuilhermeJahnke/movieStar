import 'package:MovieStar/components/custom_navBar/custom_nav_bar.dart';
import 'package:MovieStar/pages/category/category.dart';
import 'package:MovieStar/pages/home/home.dart';
import 'package:MovieStar/pages/search/search.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:flutter/material.dart';

class baseLayout extends StatefulWidget {
  baseLayout();

  _baseLayoutState createState() => _baseLayoutState();
}

class _baseLayoutState extends State<baseLayout> {
  int currentIndex = 0;
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new Home();
        break;
      case 1:
        return new Category();
        break;
      case 2:
        return new Search();
        break;
      default:
        return new Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeStyle.baseColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: callPage(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationDotBar(
          color: Color(0xFFC4C4C4),
          activeColor: ThemeStyle.baseInputColor,
          items: <BottomNavigationDotBarItem>[
            BottomNavigationDotBarItem(
                icon: Icons.insert_chart_outlined_outlined,
                title: "Inicio",
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.confirmation_number_outlined,
                title: "Categorias",
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.search,
                title: "Pesquisar",
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                }),
          ]),
    );
  }
}
