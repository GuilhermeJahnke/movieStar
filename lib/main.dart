import 'package:MovieStar/app/app_module.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting("pt_BR", null).then((_) => runApp(
        MaterialApp(home: AppModule(true, [{}]), routes: {}),
      ));
}
