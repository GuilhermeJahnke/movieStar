import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:MovieStar/shared/custom_dio/custom_dio.dart';
import 'package:flutter/material.dart';

import 'app_bloc.dart';
import 'app_widget.dart';

class AppModule extends ModuleWidget {
  final firstVisit;
  final protectedData;
  AppModule(this.firstVisit, this.protectedData);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => CustomDio()),
      ];

  @override
  Widget get view => AppWidget(firstVisit, protectedData);

  static Inject get to => Inject<AppModule>.of();
}
