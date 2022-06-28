import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

formatYear(date) {
  var data = DateTime.tryParse(date);
  if (data == null) {
    return "Data não informada";
  }
  var formattedDate = new DateFormat("yyyy").format(data);
  return formattedDate;
}

formatDate(date) {
  var data = DateTime.parse(date);
  var formattedDate = new DateFormat("dd/MM/yyyy HH:mm").format(data);
  return formattedDate;
}

Future formatCategory(date) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var categoriesString;
  var categories;
  var dateFormated = [];
  categoriesString = prefs.getString("genres");
  categories = json.decode(categoriesString);
  for (var movie in date) {
    for (var movieGenderID in movie["genre_ids"]) {
      var category = categories
          .where((category) => category["id"] == movieGenderID)
          .toList();
      if (movie["genre_name"] != null) {
        movie["genre_name"].add(category[0]);
      } else {
        movie["genre_name"] = category;
      }
    }
    dateFormated.add(movie);
  }
  return dateFormated;
}

Future formatCategoryObject(object) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var categoriesString;
  var categories;
  var dateFormated = [];
  categoriesString = prefs.getString("genres");
  categories = json.decode(categoriesString);
  for (var movieGenderID in object["genre_ids"]) {
    var category = categories
        .where((category) => category["id"] == movieGenderID)
        .toList();
    dateFormated.add(category[0]);
  }
  object["genre_name"] = dateFormated;
  return object;
}

formateCategory(categoryArr) {
  String categories = "";
  for (var category in categoryArr) {
    if (categories != "") {
      categories += ", " + category["name"];
    } else {
      categories = category["name"];
    }
  }
  return categories;
}

class CircularImage extends StatelessWidget {
  final double _width, _height;
  final ImageProvider image;
  CircularImage(this.image, {double width = 55, double height = 55})
      : _width = width,
        _height = height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: image),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black45,
            )
          ]),
    );
  }
}
