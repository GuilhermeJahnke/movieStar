import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:MovieStar/components/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:MovieStar/theme/theme.dart';
import 'package:flutter/material.dart';

class tutorial extends StatefulWidget {
  @override
  _tutorialState createState() => _tutorialState();
}

var _fontHeaderStyle = TextStyle(
    fontFamily: "Gotik",
    fontSize: 28.0,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    letterSpacing: 1.5);

var _fontDescriptionStyle = TextStyle(
    fontFamily: "Sans",
    fontSize: 14.0,
    color: Colors.white70,
    fontWeight: FontWeight.w400);

final pages = [
  new PageViewModel(
      pageColor: ThemeStyle.baseColor,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Encontre seus filmes favoritos',
        textAlign: TextAlign.center,
        style: _fontHeaderStyle,
      ),
      body: Text(
          'Encontre com facilidade os seus filmes favoritos  \n com buscas por títulos ou categorias',
          textAlign: TextAlign.center,
          style: _fontDescriptionStyle),
      mainImage: Image.asset(
        'assets/splashScreen/splash1.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      pageColor: ThemeStyle.baseColor,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Encontre o filme Perfeito',
        textAlign: TextAlign.center,
        style: _fontHeaderStyle,
      ),
      body: Text(
          "Te ajudando a encontrar rapidamente \no filme perfeito para o momento perfeito",
          textAlign: TextAlign.center,
          style: _fontDescriptionStyle),
      mainImage: Image.asset(
        'assets/splashScreen/splash2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ))
];

class _tutorialState extends State<tutorial> {
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      pageButtonsColor: Colors.black45,
      skipText: Text(
        "AVANÇAR",
        style: _fontDescriptionStyle.copyWith(
            color: ThemeStyle.baseInputColor,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      doneText: Text(
        "CONCLUIR",
        style: _fontDescriptionStyle.copyWith(
            color: ThemeStyle.baseInputColor,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      onTapDoneButton: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }
}
