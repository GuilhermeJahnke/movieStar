import 'package:MovieStar/theme/theme.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  DefaultAppBar({this.title, this.addIcon = true});

  final String title;
  final bool addIcon;
  final double appBarHeight = 60.0;

  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: 70,
              child: AppBar(
                backgroundColor: ThemeStyle.baseColor,
                automaticallyImplyLeading: false,
                leadingWidth: 35,
                iconTheme: IconThemeData(color: Colors.white70),
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios,
                              color: Colors.white70)),
                      Text(
                        title,
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black26, offset: Offset(0.0, 0.0))
      ], color: ThemeStyle.baseColor),
    );
  }
}
